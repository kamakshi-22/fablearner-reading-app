import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

class AppStyles {
  /* -------------------------------------------------------------------------- */
  /*                                    error                                   */
  /* -------------------------------------------------------------------------- */
  static TextStyle errorTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: errorRed,
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
    color: primaryRed,
    letterSpacing: 2,
    fontSize:
        MediaQuery.of(Get.context!).size.width * AppSizes().appBarTitleFontSize,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    decorationColor: darkBlue,
  ));

  /* Lesson AppBar Title */
  static TextStyle lessonAppBarTitleStyle = GoogleFonts.openSans(
      textStyle: TextStyle(
    color: primaryRed,
    fontSize: MediaQuery.of(Get.context!).size.width *
        AppSizes().lessonAppBarTitleFontSize,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    decorationColor: darkBlue,
  ));

  /* -------------------------------------------------------------------------- */
  /*                                 home drawer                                */
  /* -------------------------------------------------------------------------- */
  static TextStyle homeDrawerUsernameTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: white,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: AppSizes().drawerHeaderFontSize,
    ),
  );

  static TextStyle homeDrawerListTileTextStyle = GoogleFonts.openSans(
    textStyle: TextStyle(
      color: white,
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
      color: primaryRed,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
  );

  static TextStyle bottomNavBarUnselectedLabelTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: white,
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
    backgroundColor: primaryRed,
    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
    ),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: successGreen,
    foregroundColor: white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
    ),
  );

  static ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[300],
    foregroundColor: white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
    ),
  );

  /* Button Text Styles */
  static TextStyle buttonTextStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: darkBlue,
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
      color: white,
      letterSpacing: 1,
      fontWeight: FontWeight.bold,
      fontSize: 10.0,
    ),
  );

  static TextStyle notificationListSubtitleStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: darkBlue,
      fontWeight: FontWeight.w600,
      fontSize: 10.0,
    ),
  );

  static TextStyle notificationListTrailingStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: purple,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
      fontSize: 8.0,
    ),
  );

  /* -------------------------------------------------------------------------- */
  /*                                    card                                    */
  /* -------------------------------------------------------------------------- */

  static TextStyle cardTitleStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: darkBlue, fontWeight: FontWeight.w800, fontSize: 18),
  );

  static TextStyle cardListStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: darkBlue, fontWeight: FontWeight.w500, fontSize: 16),
  );

  static TextStyle indicatorStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      fontSize: 12,
      color: successGreen,
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
          color: primaryRed,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: white,
          width: 2,
        ),
      ),
      errorBorder: hasError
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: errorRed,
                width: 2,
              ),
            )
          : InputBorder.none,
      focusedErrorBorder: hasError
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(
                color: errorRed,
                width: 2,
              ),
            )
          : InputBorder.none,
    );
  }

  /* Form Link Style */
  static TextStyle loginStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: primaryRed,
        letterSpacing: 1,
        fontWeight: FontWeight.w800,
        fontSize: 18),
  );

  static TextStyle forgotPasswordStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
        color: white,
        letterSpacing: 1,
        fontWeight: FontWeight.bold,
        fontSize: 16),
  );

  /* Form Label Styles */
  static TextStyle formLabelStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: white,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
    ),
  );

  static TextStyle formHintStyle = GoogleFonts.openSans(
    textStyle: const TextStyle(
      color: white,
      letterSpacing: 1,
      fontWeight: FontWeight.w600,
    ),
  );
}
