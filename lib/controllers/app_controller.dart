import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

import 'package:fablearner_app/business/model/course_model.dart'
    as course_model;
import 'package:fablearner_app/business/model/lesson_model.dart'
    as lesson_model;

class AppController extends GetxController {
  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  //token
  final String token;
  AppController({required this.token});

  //model
  var courseList = <course_model.Course>[].obs;
  lesson_model.Lesson? lesson;

  // State variables
  late final RxBool isLoading = RxBool(true);
  late final RxBool isFinishing = RxBool(false);
  final error = Rxn<String>();

  // Course details variables
  int? nextLessonId;
  int? currentLessonId;

  // Finish lesson variables
  final isConfirmed = Rxn<bool>();

  // Shared preferences
  int? savedLessonId;

  /* -------------------------------------------------------------------------- */
  /*                                 main functions                             */
  /* -------------------------------------------------------------------------- */

  @override
  void onInit() {
    super.onInit();
    loadCourses();
    getSavedLesson();
    print("SAVED LESSON ID $savedLessonId");
  }

  /* -------------------------------------------------------------------------- */
  /*                                  functions                                 */
  /* -------------------------------------------------------------------------- */

  Future<void> loadCourses() async {
    try {
      isLoading.value = true;
      final loadedCourses = await CoursesApi.getCourses(token);
      update();
      courseList.assignAll(loadedCourses);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
    }
    return;
  }

  Future<int?> getSavedLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedLessonId = prefs.getInt('currentLessonId');
  }

  void getCourseDetailsByLessonId(int? lessonId) {
    final courses = courseList; // Get the courses from the RxList
    currentLessonId = lessonId; // Use the provided lessonId

    for (var course in courses) {
      for (var section in course.sections) {
        for (var item in section.items) {
          if (item.id == currentLessonId) {
            // Found the current lesson, get the next item ID
            final nextIndex = section.items.indexOf(item) + 1;

            // Check if there is a next item in the section
            if (nextIndex < section.items.length) {
              nextLessonId = section.items[nextIndex].id;
              return;
            } else {
              // If the current item is the last item in the section, set nextLessonId to 0
              nextLessonId = null;
              return;
            }
          }
        }
      }
    }
    nextLessonId = 0;
  }

  void updateLessonId() {
    getCourseDetailsByLessonId(currentLessonId);
    currentLessonId = nextLessonId?.toInt();
  }

  /* -------------------------------------------------------------------------- */
  /*                                mark complete                               */
  /* -------------------------------------------------------------------------- */

  Future<void> finishLesson() async {
    isFinishing.value = true;
    isConfirmed.value = await FinishLessonApi.finishLesson(
      token: token,
      lessonId: currentLessonId!,
    );
    isFinishing.value = false;
  }
}
