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
  RxBool isLessonFinished = false.obs;

  void setIsLessonFinished(bool value) {
    isLessonFinished.value = value;
  }

  // Shared preferences
  int? savedLessonId;

  /* -------------------------------------------------------------------------- */
  /*                                 main functions                             */
  /* -------------------------------------------------------------------------- */

  @override
  void onInit() {
    super.onInit();
    print("APPCONTROLLER: onInit() - courseList: ${courseList.length}");
    courseList.value.clear();
    print(
        "APPCONTROLLER: onInit() after clear - courseList: ${courseList.length}");
    loadCourses();
    print(
        "APPCONTROLLER: onInit() after loadCourses() - courseList: ${courseList.length}");
    getSavedLesson();
  }

  @override
  void onClose() {
    courseList.value =
        []; // Empty the course list when the controller is closed
    if (kDebugMode) {
      print('APPCONTROLLER: onClose() - courseList: $courseList');
    }
    super.onClose();
  }

  /* -------------------------------------------------------------------------- */
  /*                                  functions                                 */
  /* -------------------------------------------------------------------------- */

  Future<void> loadCourses() async {
    if (kDebugMode) {
      print("APPCONTROLLER: loadCourses()");
    }
    try {
      isLoading.value = true;
      final loadedCourses = await CoursesApi.getCourses(token);
      update();
      courseList.assignAll(loadedCourses);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      error.value = e.toString();
      if (kDebugMode) {
        print("ERROR: Error in loading courses: $e");
      }
    }
    return;
  }

  Future<int?> getSavedLesson() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedLessonId = prefs.getInt('currentLessonId');
    return null;
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
    await FinishLessonApi.finishLesson(
      token: token,
      lessonId: currentLessonId!,
    );

    isFinishing.value = false;
  }
}
