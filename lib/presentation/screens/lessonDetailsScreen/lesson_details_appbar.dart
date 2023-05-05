import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class LessonDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final RxString title;
  final VoidCallback onBackTap;
  final VoidCallback onForwardTap;

  const LessonDetailsAppBar({
    Key? key,
    required this.title,
    required this.onBackTap,
    required this.onForwardTap,
  }) : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(MediaQuery.of(Get.context!).size.height * 0.1);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            /* -------------------------------------------------------------------------- */
            /*                                 back button                                */
            /* -------------------------------------------------------------------------- */
            IconButton(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: white,
                size: AppSizes().lessonIconSize,
              ),
              onPressed: () {
                onBackTap();
              },
              splashColor: lightBlue,
              splashRadius: 20,
            ),
            /* -------------------------------------------------------------------------- */
            /*                                lesson title                                */
            /* -------------------------------------------------------------------------- */
            Expanded(
              child: Obx(() => Text(
                    title.value,
                    style: AppStyles.lessonAppBarTitleStyle,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
            /* -------------------------------------------------------------------------- */
            /*                               forward button                               */
            /* -------------------------------------------------------------------------- */
            IconButton(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: white,
                size: AppSizes().lessonIconSize,
              ),
              onPressed: () {
                onForwardTap();
              },
              splashRadius: 20,
              splashColor: lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}
