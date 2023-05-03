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
        alignment: Alignment.center,
        onPressed: () {
          appController.loadCourses();
        },
        icon: const Icon(
          Icons.refresh,
          color: lightColor,
          size: 24,
        ),
        splashColor: tertiaryColor,
        splashRadius: 20,
      ),

      /* notifications icon */
    ],
  );
}
