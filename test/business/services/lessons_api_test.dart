import 'package:flutter_test/flutter_test.dart';
import 'package:fablearner_app/exports/business_exports.dart';

void main() {
  group('Lesson API Tests', () {
    setUp(() {});
    group('getLessonData function', () {
      test('Incorrect Token', () async {
        expect(() => LessonApi.getLessonData('token', 813),
            throwsA(isInstanceOf<Exception>()));
      });

      test('Empty Token', () async {
        expect(() => LessonApi.getLessonData('', 813),
            throwsA(isInstanceOf<Exception>()));
      });

      test('Correct Token', () {
        String token ='paste_your_token';
        expect(LessonApi.getLessonData(token,813),isNotNull);
      });
    });
    


  });
}
