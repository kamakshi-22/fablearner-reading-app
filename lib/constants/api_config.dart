import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  /* base urls */
  static final String baseUrl = dotenv.env['BASE_URL']!;
  static final String loginUrl = '$baseUrl${dotenv.env['LOGIN_URL']}';

  /* data urls */
  static final String coursesUrl = '$baseUrl${dotenv.env['COURSES_URL']}';
  static final String activitiesUrl = '$baseUrl${dotenv.env['ACTIVITIES_URL']}';
  static final String lessonsUrl = '$baseUrl${dotenv.env['LESSONS_URL']}';

  /* helper urls */
  static final String forgotPasswordUrl = '$baseUrl${dotenv.env['FORGOT_PASSWORD_URL']}';
  static final String meetingsUrl = '$baseUrl${dotenv.env['MEETINGS_URL']}';
  static final String helpDeskUrl = '$baseUrl${dotenv.env['HELPDESK_URL']}';

  /* image urls */
  static final String bgImageUrl = '$baseUrl${dotenv.env['BG_IMAGE_URL']}';
}



/* class ApiConfig {
  /* base urls */
  static const String baseUrl = "https://app.fablearner.online";
  static const String loginUrl = "$baseUrl/wp-json/learnpress/v1/";

  /* data urls */
  static const String coursesUrl = "$baseUrl/wp-json/learnpress/v1/courses/?learned=true";
  static const String activitiesUrl =
      "$baseUrl/wp-json/learnpress/v1/courses/1191";
  static const String lessonsUrl = "$baseUrl/wp-json/learnpress/v1/lessons/";

  /* helper urls */
  static const String forgotPasswordUrl =
      "$baseUrl/wp-json/learnpress/v1/users/reset-password?user_login=";
  static const String meetingsUrl = "$baseUrl/meeting";
  static const String helpDeskUrl = "$baseUrl/helpdesk";

  /* image urls */
  static const String bgImageUrl =
      "$baseUrl/wp-content/uploads/2023/03/app-login-screen.jpg";

}
 */
