import 'package:bordered_text/bordered_text.dart';
import 'package:fablearner_app/constants/colors.dart';
import 'package:fablearner_app/constants/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final Function()? onBackButtonPressed;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool showLeadingIcon;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.actions,
    this.centerTitle = true,
    this.showLeadingIcon = false,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(
        margin: const EdgeInsets.only(top: 24, bottom: 10),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: centerTitle,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showBackButton)
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: lightColor,
                    size: 24,
                  ),
                  onPressed: onBackButtonPressed,
                  splashColor: secondaryColor,
                  splashRadius: 20,
                ),
              if (showLeadingIcon)
                IconButton(
                  padding: const EdgeInsets.only(),
                  icon: const Icon(
                    Icons.menu,
                    color: lightColor,
                    size: 24,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  splashColor: secondaryColor,
                  splashRadius: 20,
                ),
              Flexible(
                  child: FittedBox(
                fit: BoxFit.scaleDown,
                child: BorderedText(
                  strokeWidth: 6.0,
                  strokeColor: secondaryColor,
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
      ),
    );
  }
}
