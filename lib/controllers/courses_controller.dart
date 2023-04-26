// import 'package:fablearner_app/business/model/course_model.dart';
// import 'package:fablearner_app/business/services/courses_api.dart';
// import 'package:get/get.dart';

// class CoursesController extends GetxController {
//   final String token;
//   var isLoading = true.obs;
//   var courses = <Course>[].obs;
//   final _courseId = 0.obs;
//   final _sectionId = 0.obs;
//   final _nextLessonId = 0.obs;

//   CoursesController({required this.token});
//   @override
//   void onInit() {
//     super.onInit();
//     loadCourses();
//   }

//   Future<void> loadCourses() async {
//     print('Loading courses...');
//     print('loading value: $isLoading');
//     try {
//       isLoading.value = true;
//       final loadedCourses = await CoursesApi.getCourses(token);
//       courses.assignAll(loadedCourses);
//       isLoading.value = false;
//       print('Courses loaded successfully.');
//       print('loading value: $isLoading');
//     } catch (e) {
//       print('Failed to load courses: $e');
//       isLoading.value = false;
//       print('loading value: $isLoading');
//     }
//     return;
//   }

//   int get courseId => _courseId.value;
//   int get sectionId => _sectionId.value;
//   int get nextLessonId => _nextLessonId.value;

//   void getCourseDetailsByLessonId(int lessonId) {
//     print('Getting course details by lesson ID...');

//     final courses = this.courses.value; // Get the courses from the RxList
//     final currentLessonId = lessonId; // Use the provided lessonId

//     for (var course in courses) {
//       for (var section in course.sections) {
//         for (var item in section.items) {
//           if (item.id == currentLessonId) {
//             // Found the current lesson, get the next item ID
//             final nextIndex = section.items.indexOf(item) + 1;

//             // Check if there is a next item in the section
//             if (nextIndex < section.items.length) {
//               _courseId.value = course.id;
//               _sectionId.value = section.id;
//               _nextLessonId.value = section.items[nextIndex].id;
//               return;
//             } else {
//               // If the current item is the last item in the section, set nextLessonId to 0
//               _nextLessonId.value = 0;
//               return;
//             }
//           }
//         }
//       }
//     }
//     _courseId.value = 0;
//     _sectionId.value = 0;
//     _nextLessonId.value = 0;
//   }
// }
