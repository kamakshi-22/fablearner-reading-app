import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/business/models/lesson_model.dart';
import 'package:http/http.dart' as http;

class LessonApi {
  static Future<Lesson> getLessonData(String token, int lessonId) async {
    final response = await http.get(
        Uri.parse('${ApiConfig.lessonsUrl}$lessonId'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      final lesson = Lesson.fromJson(jsonData);
      return lesson;
    } else {
      throw Exception("Failed to load lesson data");
    }
  }
}
