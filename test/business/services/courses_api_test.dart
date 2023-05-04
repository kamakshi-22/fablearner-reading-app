import 'package:fablearner_app/business/model/course_model.dart';
import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Course API Tests', () {
    setUp(() {});
    group('getCourses function', () {
      test('Token', () async {
        final response = await CoursesApi.getCourses(
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBwLmZhYmxlYXJuZXIub25saW5lIiwiaWF0IjoxNjgzMTc2NDgwLCJuYmYiOjE2ODMxNzY0ODAsImV4cCI6MTY4Mzc4MTI4MCwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMyJ9fX0.nf4OIP0yeA9p-aIDVGygZC2ZPQlUqI_sRrfaF76pexg');
        if (kDebugMode) {
          print("TEST: CourseApi.getCourses() returned $response");
        }
        expect(response, isNotNull);
      });
      test('Empty Token', () async {
        final response = await CoursesApi.getCourses('');
        expect(response, isEmpty);
      });
      test('Status code is 200', () async {
        final response = await CoursesApi.getCourses('your_token_here');
        expect(response, isA<List<Course>>());
        expect(response.length, 0);
      });
    });
  });
}
