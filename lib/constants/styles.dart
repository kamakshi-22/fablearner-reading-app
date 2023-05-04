import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

class AppStyles {
  /* -------------------------------------------------------------------------- */
  /*                                    error                                   */
  /* -------------------------------------------------------------------------- */
  static TextStyle errorTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: warningColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w800,
      fontSize: 12,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                   appbar                                   */
  /* -------------------------------------------------------------------------- */

  /* App Bar Title */
  static TextStyle appBarTitleStyle = GoogleFonts.abrilFatface(
      textStyle: TextStyle(
    color: primaryColor,
    letterSpacing: 2,
    fontSize:
        MediaQuery.of(Get.context!).size.width * AppSizes().appBarTitleFontSize,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    decorationColor: secondaryColor,
  ));

  /* Lesson AppBar Title */
  static TextStyle lessonAppBarTitleStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
    color: primaryColor,
    fontSize: MediaQuery.of(Get.context!).size.width *
        AppSizes().lessonAppBarTitleFontSize,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    decorationColor: secondaryColor,
  ));

  /* -------------------------------------------------------------------------- */
  /*                                 home drawer                                */
  /* -------------------------------------------------------------------------- */
  static TextStyle homeDrawerUsernameTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: lightColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: AppSizes().drawerHeaderFontSize,
    ),
  );

  static TextStyle homeDrawerListTileTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: lightColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: AppSizes().drawerHeaderListTileFontSize,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                bottom navbar                               */
  /* -------------------------------------------------------------------------- */
  static TextStyle bottomNavBarSelectedLabelTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: primaryColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
  );

  static TextStyle bottomNavBarUnselectedLabelTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: lightColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                   Buttons                                  */
  /* -------------------------------------------------------------------------- */

  /* Button Design Styles */
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: successColor,
    foregroundColor: lightColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
    ),
  );

  static ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[300],
    foregroundColor: lightColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
    ),
  );

  /* Button Text Styles */
  static TextStyle buttonTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: secondaryColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w800,
      fontSize: 16,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                              notification list                             */
  /* -------------------------------------------------------------------------- */
  static TextStyle notificationListTitleStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: lightColor,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
      fontSize: 16.0,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                    card                                    */
  /* -------------------------------------------------------------------------- */

  static TextStyle cardTitleStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: secondaryColor, fontWeight: FontWeight.w800, fontSize: 18),
  );

  static TextStyle cardListStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: secondaryColor, fontWeight: FontWeight.w500, fontSize: 16),
  );

  static TextStyle indicatorStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      fontSize: 12,
      color: successColor,
      fontWeight: FontWeight.w800,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                 form style                                 */
  /* -------------------------------------------------------------------------- */

  static InputDecoration formInputDecoration(
    String labelText,
    String hintText,
    RxString? errorText,
  ) {
    String? errorString = errorText?.value; // Convert RxString to String
    bool hasError = errorString != null && errorString.isNotEmpty;
    return InputDecoration(
      labelText: labelText,
      labelStyle: formLabelStyle,
      hintText: hintText,
      hintStyle: formHintStyle,
      errorText: hasError ? errorString : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
      errorBorder: hasError
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: warningColor,
                width: 2,
              ),
            )
          : InputBorder.none,
      focusedErrorBorder: hasError
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: warningColor,
                width: 2,
              ),
            )
          : InputBorder.none,
    );
  }

  /* Form Link Style */
  static TextStyle loginStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: primaryColor,
        letterSpacing: 1,
        fontWeight: FontWeight.w800,
        fontSize: 18),
  );

  static TextStyle forgotPasswordStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: lightColor,
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
        fontSize: 16),
  );

  /* Form Label Styles */
  static TextStyle formLabelStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: lightColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextStyle formHintStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: lightColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
    ),
  );
}
