import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Function()? onBackButtonPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool showMenuIcon;
  final Color backgroundColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.actions,
    this.centerTitle = true,
    this.showMenuIcon = false,
    this.backgroundColor = darkBlue,
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
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: centerTitle,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showMenuIcon)
              IconButton(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(),
                icon: Icon(
                  Icons.menu,
                  color: white,
                  size: AppSizes().menuIconSize,
                ),
                splashColor: lightBlue,
                splashRadius: 20,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            if (showBackButton)
              IconButton(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: white,
                  size: AppSizes().backIconSize,
                ),
                onPressed: onBackButtonPressed,
                splashColor: lightBlue,
                splashRadius: 20,
              ),
            Flexible(
                child: FittedBox(
              fit: BoxFit.scaleDown,
              child: BorderedText(
                strokeWidth: 6.0,
                strokeColor: darkBlue,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: AppStyles.appBarTitleStyle,
                ),
              ),
            )),
          ],
        ),
        actions: actions,
      ),
    );
  }
}
