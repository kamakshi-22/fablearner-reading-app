import '../../../exports/business_exports.dart';
import 'login_form.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    NotificationServices().requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "FabLearner", showBackButton: false),
      body: Stack(children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: ApiConfig.bgImageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: SpinKitThreeBounceAnimation(),
            ),
            errorWidget: (context, url, error) => Image.asset(
              "assets/images/bg.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GetBuilder<LoginController>(builder: (_) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 1200),
                    curve: Curves.easeInOut,
                    height: _.showLoginForm
                        ? MediaQuery.of(context).size.height
                        : 0,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                    ),
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: LoginScreenForm(),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GetBuilder<LoginController>(builder: (_) {
                return Visibility(
                  visible: !_.showLoginForm,
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: ElevatedButton(
                      style: AppStyles.primaryButtonStyle,
                      child: Text(
                        "Login".toUpperCase(),
                        style: AppStyles.buttonTextStyle,
                      ),
                      onPressed: () {
                        _.animationController.forward();
                        _.toggleLoginForm();
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ]),
    );
  }
}
