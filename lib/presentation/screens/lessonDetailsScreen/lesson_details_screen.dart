import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:flutter_html/flutter_html.dart';

class LessonDetailsScreen extends StatefulWidget {
  final String token;
  final int lessonId;
  const LessonDetailsScreen({
    super.key,
    required this.token,
    required this.lessonId,
  });

  @override
  _LessonDetailsScreenState createState() => _LessonDetailsScreenState();
}

class _LessonDetailsScreenState extends State<LessonDetailsScreen> {
  bool snackBarIsVisible = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: LessonDetailsAppBar(
          title: lessonName, onBackTap: backTap, onForwardTap: forwardTap),
      body: Center(
        child: Obx(() {
          if (isLoading.value ||
              error.value != '' ||
              appController.isLoading.value) {
            return const SpinKitThreeBounce(
              color: primaryColor,
              size: 24,
            );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20.0),
                    child: Obx(() {
                      if (appController.isFinishing.value) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              SpinKitThreeBounce(
                                color: primaryColor,
                                size: 24,
                              ),
                            ]);
                      } else {
                        return ElevatedButton(
                          style: lessonFinished.value
                              ? AppStyles.disabledButtonStyle
                              : AppStyles.secondaryButtonStyle,
                          onPressed: lessonFinished.value
                              ? null
                              : () async {
                                  if (!appController.isFinishing.value) {
                                    appController.isFinishing.value = true;
                                    await appController.finishLesson();

                                    if (appController.isConfirmed.value !=
                                        null) {
                                      _fetchLessonDetails(widget.lessonId);
                                    }
                                  }
                                },
                          child: const Text('Finish Lesson'),
                        );
                      }
                    }),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (lessonUrl.value != '' ||
                              lessonUrl.value.isNotEmpty)
                            SizedBox(
                                height: screenHeight * 0.6,
                                width: screenWidth,
                                child: Chewie(controller: _chewieController!)),
                          if (lessonUrl.value == '' || lessonUrl.value.isEmpty)
                            Html(
                              data: lessonContent.value,
                              style: {
                                'body': Style(
                                  fontSize: FontSize.medium,
                                ),
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ]);
          }
        }),
      ),
    );
  }

  late final RxString lessonName = RxString('');
  late final RxString lessonUrl = RxString('');
  late final RxString lessonContent = RxString('');
  late final RxBool lessonFinished = RxBool(false);

  late final RxBool isLoading = RxBool(true);
  late final RxString error = RxString('');

  late final AppController appController;
  late ChewieController? _chewieController;
  late QrScannerController? qrController;

  @override
  void initState() {
    super.initState();
    appController = Get.find<AppController>();
    _fetchLessonDetails(widget.lessonId);
    appController.getCourseDetailsByLessonId(widget.lessonId);
    saveLesson();
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print('DISPOSE CALLED void dispose()');
    }
    removeLesson();
    disposeVideo();
    super.dispose();
  }

  void disposeVideo() {
    if (_chewieController != null) {
      _chewieController!.pause();
      _chewieController!.videoPlayerController.pause();
      _chewieController!.videoPlayerController.removeListener(() {});
      _chewieController!.videoPlayerController.dispose();
      _chewieController!.dispose();
    }
  }

  void backTap() {
    removeLesson();
    Get.back();
  }

  void forwardTap() {
    if (isLoading.value) {
      print("FORWARD TAP DISABLED");
      return;
    }
    if (snackBarIsVisible == false) {
      appController.updateLessonId();
    }

    if (appController.nextLessonId == null || snackBarIsVisible == true) {
      Get.snackbar(
        'No more lessons found',
        'You have watched all the lessons in this section',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        colorText: Colors.black,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
        duration: const Duration(seconds: 5),
        dismissDirection: DismissDirection.horizontal,
      );
      snackBarIsVisible = true;
      //disable forward button
    } else {
      if (kDebugMode) {
        print('DISPOSE CALLED void forwardTap()');
      }
      disposeVideo();
      _fetchLessonDetails(appController.currentLessonId!);
      saveLesson();
    }
  }

  Future<void> saveLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentLessonId', appController.currentLessonId!);
  }

  Future<void> removeLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('currentLessonId');
    appController.savedLessonId = null;
  }

  Future<void> _fetchLessonDetails(int fetchLessonId) async {
    isLoading.value = true;
    try {
      final lesson = await LessonApi.getLessonData(widget.token, fetchLessonId);
      lessonContent.value = lesson.content;
      lessonUrl.value =
          RegExp(r'src="([^"]+?)"').firstMatch(lessonContent.value)?.group(1) ??
              '';
      lessonName.value = lesson.name;
      lessonFinished.value = lesson.results.status == 'completed';

      if (kDebugMode) {
        print('lessonUrl.value: ${lessonUrl.value}');
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
    }

    _chewieController = ChewieController(
      videoPlayerController: VideoPlayerController.network(lessonUrl.value),
      aspectRatio: 16 / 9,
      autoInitialize: true,
      allowPlaybackSpeedChanging: true,
      showControls: true,
      allowFullScreen: true,
      allowMuting: true,
      looping: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: primaryColor,
        handleColor: primaryColor,
        backgroundColor: lightColor,
        bufferedColor: successColor,
      ),
      placeholder: const Center(
        child: SpinKitThreeBounce(
          color: primaryColor,
          size: 24,
        ),
      ),
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: AppStyles.errorTextStyle,
          ),
        );
      },
    );
  }
}
