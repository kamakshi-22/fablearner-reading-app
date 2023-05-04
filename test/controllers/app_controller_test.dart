import 'package:fablearner_app/business/models/course_model.dart'
    as course_model;
import 'package:fablearner_app/business/models/lesson_model.dart'
    as lesson_model;

import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App Controller Tests', () {
    late AppController appController;

    setUp(() {
      String test_token =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBwLmZhYmxlYXJuZXIub25saW5lIiwiaWF0IjoxNjgxODc0NzkxLCJuYmYiOjE2ODE4NzQ3OTEsImV4cCI6MTY4MjQ3OTU5MSwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMyJ9fX0.riR2vFQYt4mWFZvlkowAHC9IGnTF-g9qPQT7mef0km8';
      appController = AppController(token: test_token);
    });

    group('courses function', () {
      group('loadCourses function', () {
        test('should load courses successfully', () async {
          // Act
          await appController.loadCourses();
          print(appController.courseList.length);
          // Assert
          expect(appController.isLoading.value, false);
          expect(appController.courseList.isNotEmpty, true);
          expect(appController.courseList.length, greaterThan(0));
        });

        test('should set isLoading to false if an error occurs', () async {
          // Set an invalid token to force an error
          appController = AppController(token: 'invalid_token');

          // Call the loadCourses function
          await appController.loadCourses();

          // Make assertions on the properties that should have been updated
          expect(appController.isLoading.value, false);
          expect(appController.courseList.isEmpty, true);
        });
      });
    });

    // group('lessons function', () {
    //   group('fetchLessonContentDetails function', () {
    //     test('Correct Lesson Id should fetch lesson content details', () async {
    //       // Arrange
    //       const lessonId = 816;
    //       // Act
    //       await appController.fetchLessonContentDetails(lessonId);

    //       print("loading status: ${appController.isLoading}");
    //       print("error: ${appController.error}");

    //       print("url: ${appController.url}");
    //       print("content: ${appController.content}");
    //       // Assert
    //       expect(appController.error, Rxn<String>(null));
    //     });

    //     test('Incorrect Lesson Id should show error', (() async {
    //       // Arrange
    //       const lessonId = 111222;
    //       // Act
    //       await appController.fetchLessonContentDetails(lessonId);

    //       print("error: ${appController.error}");
    //       print("loading status: ${appController.isLoading}");

    //       print("url: ${appController.url}");
    //       print("content: ${appController.content}");
    //       // Assert
    //       expect(appController.error, isNotNull);
    //     }));

    //     test('Incorrect Token should show error', (() async {
    //       // Arrange
    //       String test_token = 'incorrect_token';
    //       appController = AppController(token: test_token);
    //       const lessonId = 812;

    //       // Act
    //       await appController.fetchLessonContentDetails(lessonId);

    //       print("error: ${appController.error}");
    //       print("loading status: ${appController.isLoading}");

    //       print("url: ${appController.url}");
    //       print("content: ${appController.content}");

    //       // Assert
    //       expect(appController.error, isNotNull);
    //     }));
    //   });

    // });
  });
}
