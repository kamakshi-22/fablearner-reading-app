import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/exports/common_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('token');
  runApp(MyApp(token: token));
  //print(token);
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
        '/': (context) => LoginScreen(),
        '/courses': (context) => HomeScreen(token: token!),
      },
    );
  }
}
