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

