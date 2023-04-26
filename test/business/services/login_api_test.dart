import 'package:fablearner_app/exports/business_exports.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fablearner_app/exports/common_exports.dart';
void main() {
  group('Login API Tests', () {
    setUp(() {});
    group('loginApiCall function', () {
      test('Correct Username & Password', () async {
        final response =
            await LoginApi.loginApiCall('test_user_1', 'testuser_1022');
        expect(response.statusCode, 200);
      });
      test('Login API class prints the correct token', () async {
        final response =
            await LoginApi.loginApiCall('test_user_1', 'testuser_1022');
        final data = jsonDecode(response.body);
        final token = data['token'];

        print("Token: $token");
        
        expect(token, isNotNull);
      });
      test('Empty Username', () async {
        expect(() => LoginApi.loginApiCall('', 'password'),
            throwsA(isInstanceOf<Exception>()));
      });
      test('Empty Password', () {
        expect(() => LoginApi.loginApiCall('username', ''),
            throwsA(isInstanceOf<Exception>()));
      });
    });
  });
}
