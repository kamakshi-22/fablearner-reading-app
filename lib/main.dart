import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundController);
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  if (kDebugMode) {
    print('TOKEN: $token - main.dart');
  }
  runApp(MyApp(token: token));
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundController(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(
        'Handling a background message ${message.notification!.title.toString()}');
  }
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? '/courses' : '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/courses': (context) => HomeScreen(token: token!),
      },
    );
  }
}
