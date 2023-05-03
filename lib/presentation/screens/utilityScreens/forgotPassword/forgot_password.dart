import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/business_exports.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    setState(() {
      _isLoading = true;
    });

    final username = _usernameController.text.trim();
    final isResetSuccessful = await ForgotPasswordApi.resetPassword(username);

    if (isResetSuccessful) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          backgroundColor: successColor,
          content: Text(
            'Password reset email sent to $username.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          backgroundColor: warningColor,
          content: Text(
            'Failed to reset password. \n Check your username or email.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: CustomAppBar(
        title: 'Forgot Password',
        showBackButton: true,
        centerTitle: false,
        onBackButtonPressed: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _usernameController,
                style: AppStyles.formLabelStyle,
                decoration: InputDecoration(
                  labelText: 'Username or email',
                  labelStyle: AppStyles.formLabelStyle,
                  hintText: 'Enter your username or email',
                  hintStyle: AppStyles.formLabelStyle,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: lightColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: warningColor,
                      width: 2,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: const BorderSide(
                      color: warningColor,
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username or email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: _isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          _resetPassword();
                        }
                      },
                child: Center(
                  child: _isLoading
                      ? const SpinKitThreeBounce(
                          color: primaryColor,
                          size: 24,
                        )
                      : Text(
                          'Click to Reset Password',
                          style: AppStyles.forgotPasswordStyle,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
