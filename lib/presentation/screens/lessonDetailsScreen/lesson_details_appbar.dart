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
  Widget build(BuildContext context) {
    //return Obx(() {
      return Container(
        margin: const EdgeInsets.only(top: 24, bottom: 10, left: 5, right: 5),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: lightColor,
                  size: 24,
                ),
                onPressed: () {
                  onBackTap();
                },
                splashColor: secondaryColor,
                splashRadius: 20,
              ),
              Expanded(
                child: Obx(() => Text(
                title.value,
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              )),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: lightColor,
                  size: 24,
                ),
                onPressed: () {
                  onForwardTap();
                },
                splashRadius: 20,
              ),
            ],
          ),
        ),
      );
   // });
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
