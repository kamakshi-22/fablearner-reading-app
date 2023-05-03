import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

CustomAppBar coursesAppBar(
    {required String token, required BuildContext context}) {
  final appController = Get.find<AppController>();
  return CustomAppBar(
    title: 'Fab Courses',
    showBackButton: false,
    centerTitle: false,
    showLeadingIcon: true,
    actions: [
      IconButton(
        onPressed: () {
          appController.loadCourses();
        },
        icon: const Icon(Icons.refresh),
        splashRadius: 20,
      ),
      IconButton(
        icon: const Icon(Icons.logout),
        splashRadius: 20,
        onPressed: () async {

          /* Remove saved token and username */
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await prefs.remove('username');

          /* Navigate to login screen */
          Get.offAllNamed(
            '/',
          );
          Get.to(
            const LoginScreen(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.leftToRightWithFade,
          );
        },
      ),
    ],
  );
}
