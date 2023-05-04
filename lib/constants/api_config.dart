class ApiConfig {
  /* base urls */
  static const String baseUrl = "https://app.fablearner.online";
  static const String loginUrl = "$baseUrl/wp-json/learnpress/v1/";

  /* data urls */
  static const String coursesUrl = "$baseUrl/wp-json/learnpress/v1";
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

  //static const String quizUrl = "$baseUrl/wp-json/learnpress/v1/quizzes/";
}
