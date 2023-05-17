import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordApi {
  static Future<bool> resetPassword(String username) async {
    final url = Uri.parse(ApiConfig.forgotPasswordUrl! + username);

    try {
      final response = await http.post(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: Failed to reset password: ${e.toString()}");
      }
      return false;
    }
  }
}
