import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

CustomAppBar coursesAppBar(
    {required String token, required BuildContext context}) {
  final appController = Get.find<AppController>();
  return CustomAppBar(
    title: 'Fab Courses',
    showBackButton: false,
    centerTitle: false,
    showMenuIcon: true,
    actions: [
      IconButton(
        alignment: Alignment.center,
        onPressed: () {
          appController.loadCourses();
        },
        icon: Icon(
          Icons.refresh,
          color: white,
          size: AppSizes().refreshIconSize,
        ),
        splashColor: lightBlue,
        splashRadius: 20,
      ),

      /* notifications icon */
      IconButton(
        alignment: Alignment.center,
        onPressed: () {
          Get.to(
            () => const NotificationScreen(),
            duration: 800.milliseconds,
            transition: Transition.rightToLeft,
          );
        },
        icon: Icon(
          Icons.notifications,
          color: white,
          size: AppSizes().refreshIconSize,
        ),
        splashColor: lightBlue,
        splashRadius: 20,
      ),
    ],
  );
}
