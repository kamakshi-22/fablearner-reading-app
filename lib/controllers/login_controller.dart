import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
/* Responsible for handling the state of the login screen and the login form */
class LoginController extends GetxController with GetSingleTickerProviderStateMixin {

  /* -------------------------------------------------------------------------- */
  /*                                  variables                                 */
  /* -------------------------------------------------------------------------- */

  /* toggle between login button and login form */
  bool _showLoginForm = false;
  bool get showLoginForm => _showLoginForm;
  
  /* Animation controller for the login form */
  late AnimationController animationController;
  late Animation<double> heightFactorAnimation;
  bool loginButtonVisible = true;
  
  /* WebViewController for forgot password screen */
  late final WebViewController controller;

  /* Controllers and Observables for the login form */
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _responseText = ''.obs;
  final _usernameError = ''.obs;
  final _passwordError = ''.obs;
  final _isLoading = false.obs;
  final _isPasswordVisible = false.obs;
  final _previousUsernames = <String>[].obs;
  get searchController => null;

  /* Getters */
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  RxString get responseText => _responseText;
  RxString get usernameError => _usernameError;
  RxString get passwordError => _passwordError;
  RxBool get isLoading => _isLoading;
  RxBool get isPasswordVisible => _isPasswordVisible;
  List<String> get previousUsernames => _previousUsernames;

  /* -------------------------------------------------------------------------- */
  /*                                 constructor                                */
  /* -------------------------------------------------------------------------- */

  /* Constructor */
  LoginController() {
    /* Animation controller initialization */
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    heightFactorAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    /* WebViewController initialization */
    //controller = WebViewController()..loadRequest(Uri.parse(ApiConfig.forgotPasswordUrl));
  }

  /* -------------------------------------------------------------------------- */
  /*                                  functions                                 */
  /* -------------------------------------------------------------------------- */

  /* Toggle the login form visibility */
  void toggleLoginForm() {
    _showLoginForm = !_showLoginForm;
    update();
  }

  /* Toggle password visibility */
  void toggleVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  /* Handle login */
  void handleLogin(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;
    _onUsernameError("");
    _onPasswordError("");

    _isLoading.value = true;

    // Add the entered username to the previousUsernames list
    if (username.isNotEmpty && !_previousUsernames.contains(username)) {
      _previousUsernames.add(username);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      LoginApi.login(
        context,
        username,
        password,
        _onSuccess,
        _onUsernameError,
        _onPasswordError,
        _onLoginError,
      );
    });
  }

  /* Handle forgot password */
  void handleForgotPassword() {
    Get.to(
      () => ForgotPassword(),
      duration: const Duration(milliseconds: 800),
      transition: Transition.rightToLeft,
    );
  }

  /* Clean up resources */
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    animationController.dispose();
    super.dispose();
  }

  /* Callback function for login success */
  void _onSuccess(String message) {
    _isLoading.value = false;
    _responseText.value = '';
  }

  /* Callback function for username error */
  void _onUsernameError(String message) {
    _usernameError.value = message;
    _isLoading.value = false;
  }

  /* Callback function for password error */
  void _onPasswordError(String message) {
    _passwordError.value = message;
    _isLoading.value = false;
  }

  /* Callback function for login error */
  void _onLoginError(String message) {
    _responseText.value = message;
    _isLoading.value = false;
  }

}

