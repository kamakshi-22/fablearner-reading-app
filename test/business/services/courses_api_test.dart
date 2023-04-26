import 'package:fablearner_app/business/model/course_model.dart';
import 'package:fablearner_app/exports/business_exports.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Course API Tests', () {
    setUp(() {});
    group('getCourses function', () {
      test('Token', () async {
        final response = await CoursesApi.getCourses('eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBwLmZhYmxlYXJuZXIub25saW5lIiwiaWF0IjoxNjgyMDUxMDk3LCJuYmYiOjE2ODIwNTEwOTcsImV4cCI6MTY4MjY1NTg5NywiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMTMifX19.AjNYu-pRDJcdJniO3yD_T8lW2iybf8zaYoVFeZmlpJo');
        print(response);
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
