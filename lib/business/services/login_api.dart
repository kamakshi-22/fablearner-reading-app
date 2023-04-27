import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<http.Response> loginApiCall(
      String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      throw Exception("Please enter username and password");
    }

    final response = await http.post(
      Uri.parse("${ApiConfig.loginUrl}token"),
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'] as String;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
    } else {
      return http.Response('Wrong login credentials', 401);
    }
    return response;
  }

  static void login(
    BuildContext context,
    String username,
    String password,
    void Function(String) onSuccess,
    void Function(String) onUsernameError,
    void Function(String) onPasswordError,
    void Function(String) onLoginError,
  ) async {
    final loginController = Get.find<LoginController>();
    if (username.isEmpty) {
      onUsernameError("Please enter username");
      return;
    } else if (password.isEmpty) {
      onPasswordError("Please enter password");
      return;
    }

    try {
      final response = await loginApiCall(username, password);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'] as String;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('username', username);
        onSuccess("Login successful and Token saved");
        loginController.toggleLoginForm();
        loginController.usernameController.clear();
        loginController.passwordController.clear();
        Get.to(() => HomeScreen(token: token),
            duration: const Duration(milliseconds: 800),
            transition: Transition.rightToLeft);
      } else {
        onLoginError("Wrong username or password");
      }
    } catch (e) {
      onLoginError(e.toString());
    }
  }
}
