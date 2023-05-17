import 'dart:convert';
import '../../constants/api_config.dart';
import 'package:http/http.dart' as http;

class ActivitiesCourseApi {
  static Future<Map<String, dynamic>> getCourses(String token) async {
    final response = await http.get(
      Uri.parse(ApiConfig.activitiesUrl!),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return jsonData;
    } else {
      throw Exception("Failed to load courses");
    }
  }
}
