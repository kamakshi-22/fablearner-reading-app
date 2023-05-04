import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

import 'package:fablearner_app/business/model/course_model.dart';
import 'package:http/http.dart' as http;

class CoursesApi {
  static Future<List<Course>> getCourses(String token) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.coursesUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        if (kDebugMode) {
          print("JSON DATA from CourseApi.getCourses(): $jsonData");
        }
        final courses = jsonData.map((json) => Course.fromJson(json)).toList();
        if (kDebugMode) {
          print("SUCCESS: CourseApi.getCourses() returned ${courses.length} courses}");
        }
        return courses;
      } else {
        throw Exception(
            "ERROR: CourseApi.getCourses() failed with status code ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("ERROR: CourseApi.getCourses() failed with exception $e");
    }
  }
}
