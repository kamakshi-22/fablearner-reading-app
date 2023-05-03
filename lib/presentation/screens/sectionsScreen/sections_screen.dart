import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class SectionsScreen extends StatefulWidget {
  final String token;
  final int courseId;

  const SectionsScreen({
    Key? key,
    required this.token,
    required this.courseId,
  }) : super(key: key);

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final course = appController.courseList
        .firstWhere((course) => course.id == widget.courseId);
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: CustomAppBar(
          title: course.name,
          showBackButton: true,
          centerTitle: false,
          onBackButtonPressed: () {
            Get.back();
          },
          actions: [
            IconButton(
              onPressed: () async {
                setState(() {});
                await appController.loadCourses();
                setState(() {});
              },
              icon: const Icon(Icons.refresh),
              splashRadius: 20,
            ),
          ]),
      body: GetBuilder<AppController>(builder: (controller) {
        if (controller.isLoading.value) {
          return const SpinKitThreeBounceAnimation();
        } else {
          return ListView.builder(
            itemCount: appController.courseList
                .firstWhere((course) => course.id == widget.courseId)
                .sections
                .length,
            itemBuilder: (context, index) {
              final section = appController.courseList
                  .firstWhere((course) => course.id == widget.courseId)
                  .sections[index];
              return SizedBox(
                height: 120,
                width: 200,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Card(
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: cardBackgroundColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () async {
                                Get.to(
                                  () => LessonsScreen(
                                    token: widget.token,
                                    courseId: widget.courseId,
                                    sectionId: section.id,
                                  ),
                                  duration: 800.milliseconds,
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      section.title,
                                      style: AppStyles.cardTitleStyle,
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: SizedBox(
                                              width:
                                                  240, // Adjust this value as needed
                                              height: 10,
                                              child: LinearProgressIndicator(
                                                value: section.percent / 100,
                                                backgroundColor:
                                                    Colors.grey[300],
                                                valueColor:
                                                    const AlwaysStoppedAnimation<
                                                        Color>(successColor),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "${section.percent} %",
                                            //toPrecision(2),
                                            style: AppStyles.indicatorStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          //}
        }
      }),
    );
  }
}

// Get.off(
            //   () => HomeScreen(token: token),
            //   duration: 800.milliseconds,
            //   transition: Transition.leftToRight,
            // );
