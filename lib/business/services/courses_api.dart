import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

import 'package:fablearner_app/business/model/course_model.dart';
import 'package:http/http.dart' as http;

class CoursesApi {
  static Future<List<Course>> getCourses(String token) async {
    final response = await http.get(
      Uri.parse("${ApiConfig.coursesUrl}/courses/?learned=true"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final courses = jsonData.map((json) => Course.fromJson(json)).toList();
      return courses;
    } else {
      throw Exception("Failed to load courses");
    }
  }
}
