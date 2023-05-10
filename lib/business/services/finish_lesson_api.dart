import 'package:fablearner_app/exports/business_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:http/http.dart' as http;

class FinishLessonApi {
  static Future<bool?> finishLesson({
    required String token,
    required int lessonId,
  }) async {
    bool showPopup = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('showPopup') == false) {
      showPopup = false;
    }

    if (showPopup) {
      bool? confirm = await showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('You won\'t be able to reverse this action.'),
            actions: <Widget>[
              TextButton(
                child: const Text('Continue'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
              TextButton(
                child: const Text('Don\'t show this again'),
                onPressed: () async {
                  await prefs.setBool('showPopup', false);
                  Navigator.of(Get.context!).pop(false);
                },
              ),
            ],
          );
        },
      );
      if (confirm == null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Error: No option selected.'),
            backgroundColor: Colors.red,
          ),
        );
      } else if (confirm) {
        await _executeFinishLesson(
          token,
          lessonId,
        ); // Call the API request function
      }
      return confirm;
    } else {
      await _executeFinishLesson(
        token,
        lessonId,
      ); // Call the API request function
      return null;
    }
  }

  static Future<void> _executeFinishLesson(
    String token,
    int lessonId,
  ) async {
    final httpClient = http.Client();

    try {
      final response = await httpClient.post(
        Uri.parse('${ApiConfig.lessonsUrl}finish?id=$lessonId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        AppController appController = Get.find<AppController>();
        appController.setIsLessonFinished(true);
        final responseData = jsonDecode(response.body);
        final message = responseData['message'];
        final snackBarColor =
            message == 'You have already completed this lesson.'
                ? Colors.red
                : Colors.green;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: snackBarColor,
          ),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(
            content: Text('Error finishing this lesson'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Error connecting to the server.'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      httpClient.close();
    }
  }
}
