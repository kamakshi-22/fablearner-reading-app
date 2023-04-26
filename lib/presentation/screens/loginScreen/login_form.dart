import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

class LoginScreenForm extends StatelessWidget {
  final LoginController loginController = Get.find<LoginController>();
  TextEditingController searchController = TextEditingController();
  LoginScreenForm({super.key});

  @override
  Widget build(BuildContext context) {
    RxString selectedUsername = ''.obs;
    return Form(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return TextFormField(
                  controller: loginController.usernameController,
                  style: AppStyles.formLabelStyle,
                  decoration: AppStyles.formInputDecoration(
                    "Username",
                    "Enter your username",
                    loginController.usernameError,
                  ),
                  onChanged: (value) {
                    loginController.usernameError.value = "";
                    loginController.responseText.value = "";
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      loginController.usernameError.value =
                          "Please enter your username";
                    } else {
                      loginController.usernameError.value = "";
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return TextFormField(
                  controller: loginController.passwordController,
                  obscureText: !loginController.isPasswordVisible.value,
                  style: AppStyles.formLabelStyle,
                  decoration: AppStyles.formInputDecoration(
                    "Password",
                    "Enter your password",
                    loginController.passwordError,
                  ).copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        loginController.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: primaryColor,
                      ),
                      onPressed: () {
                        loginController.isPasswordVisible.value =
                            !loginController.isPasswordVisible.value;
                      },
                    ),
                  ),
                  onChanged: (value) {
                    loginController.passwordError.value = "";
                    loginController.responseText.value = "";
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      loginController.passwordError.value =
                          "Please enter your password";
                    } else {
                      loginController.passwordError.value = "";
                    }
                    return null;
                  },
                );
              }),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return loginController.isLoading.value
                    ? const SpinKitThreeBounceAnimation()
                    : GestureDetector(
                        onTap: () => loginController.handleLogin(context),
                        child: Text(
                          "Login".toUpperCase(),
                          style: AppStyles.loginStyle,
                        ),
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                return Text(
                  loginController.responseText.value,
                  style: AppStyles.formErrorStyle,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: loginController.handleForgotPassword,
                child: Text(
                  'Forgot Password?',
                  style: AppStyles.forgotPasswordStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
