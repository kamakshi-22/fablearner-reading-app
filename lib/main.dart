import 'package:device_preview/device_preview.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundController);
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  runApp(
    DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => MyApp(token: token)), // Wrap your app
  );

  //MyApp(token: token));
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundController(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  print(
      'Handling a background message ${message.notification!.title.toString()}');
}

class MyApp extends StatelessWidget {
  final String? token;
  const MyApp({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      initialRoute: token != null ? '/courses' : '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/courses': (context) => HomeScreen(token: token!),
      },
    );
  }
}
