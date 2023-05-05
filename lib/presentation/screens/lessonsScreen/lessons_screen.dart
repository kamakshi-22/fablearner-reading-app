import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

import 'package:fablearner_app/business/model/course_model.dart'
    as course_model;

class LessonsScreen extends StatefulWidget {
  final String token;
  final int courseId;
  final int sectionId;

  const LessonsScreen({
    Key? key,
    required this.token,
    required this.courseId,
    required this.sectionId,
  }) : super(key: key);

  @override
  State<LessonsScreen> createState() => _LessonsScreenState();
}

class _LessonsScreenState extends State<LessonsScreen> {
  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final course = appController.courseList
        .firstWhere((course) => course.id == widget.courseId);
    final sections = course.sections;

    return Scaffold(
      backgroundColor: darkBlue,
      appBar: CustomAppBar(
          title: sections
              .firstWhere((section) => section.id == widget.sectionId)
              .title,
          showBackButton: true,
          centerTitle: false,
          onBackButtonPressed: () {
            Get.back();
          },
          actions: [
            IconButton(
              alignment: Alignment.center,
              onPressed: () async {
                setState(() {});
                await appController.loadCourses();
                setState(() {});
              },
              icon: Icon(
                Icons.refresh,
                color: white,
                size: AppSizes().refreshIconSize,
              ),
              splashColor: lightBlue,
              splashRadius: 20,
            ),
          ]),
      body: GetBuilder<AppController>(
        init: appController,
        builder: (controller) {
          if (controller.isLoading.value) {
            // Display a circular progress indicator while loading data
            return const LoadingAnimation();
          } else {
            final section = sections
                .firstWhere((section) => section.id == widget.sectionId);

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: section.items.length,
                    itemBuilder: (context, lessonIndex) {
                      final lesson = section.items[lessonIndex];
                      return SizedBox(
                        height: 80,
                        width: 80,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Card(
                            elevation: 0,
                            color: lightBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: InkWell(
                              onTap: () async {
                                Get.to(
                                  () => LessonDetailsScreen(
                                    token: widget.token,
                                    lessonId: lesson.id,
                                  ),
                                  duration: 800.milliseconds,
                                  transition: Transition.rightToLeft,
                                );
                              },
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    child: Checkbox(
                                      value: lesson.status 
                                      //== 'completed',
                                      == course_model.Status.COMPLETED,
                                      checkColor: Colors.white,
                                      fillColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (lesson.status 
                                          //== 'completed') {
                                            == course_model.Status.COMPLETED) {
                                            return successGreen;
                                          } else {
                                            return Colors.grey.withOpacity(0.4);
                                          }
                                        },
                                      ),
                                      onChanged: null,
                                      shape: const CircleBorder(),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      lesson.title,
                                      style: AppStyles.cardListStyle
                                          .copyWith(color: white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

// if (widget.courseId == 0 || widget.courseId == null) {

//   Get.off(
//     () => HomeScreen(token: widget.token),
//     duration: 800.milliseconds,
//     transition: Transition.leftToRight,
//   );
// } else {
//   Get.off(
//     () => SectionsScreen(
//       token: widget.token,
//       courseId: widget.courseId,
//     ),
//     duration: 800.milliseconds,
//     transition: Transition.leftToRight,
//   );
// }
