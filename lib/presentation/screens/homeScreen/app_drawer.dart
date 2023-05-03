import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    setState(() {
      _username = username;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Container(
        color: secondaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height * 0.18,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: tertiaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 18.0,
                      backgroundColor: lightColor,
                      child: Icon(
                        Icons.person_outline,
                        color: secondaryColor,
                        size: 24.0,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _username.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: lightColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.meeting_room_outlined,
                color: lightColor,
              ),
              title: Container(
                padding: EdgeInsets.zero,
                child: const Text(
                  'Weekly Meetings',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: lightColor,
                  ),
                ),
              ),
              onTap: () {
                /* Close the drawer */
                Navigator.pop(context);

                /* Navigate to meetings screen */
                Get.to(
                  () => const MeetingsScreen(),
                  duration: const Duration(milliseconds: 600),
                  transition: Transition.rightToLeft,
                );
              },
            ),
            const Divider(
              color: lightColor,
              thickness: 1.0,
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: lightColor,
              ),
              title: Container(
                padding: EdgeInsets.zero,
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: lightColor,
                  ),
                ),
              ),
              onTap: () async {
                /* Remove saved token and username */
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token');
                await prefs.remove('username');

                /* Navigate to login screen */
                Get.offAllNamed(
                  '/',
                );
                Get.to(
                  const LoginScreen(),
                  duration: const Duration(milliseconds: 300),
                  transition: Transition.leftToRightWithFade,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



/* IconButton(
        icon: const Icon(Icons.logout),
        splashRadius: 20,
        onPressed: () async {
          /* Remove saved token and username */
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await prefs.remove('username');

          /* Navigate to login screen */
          Get.offAllNamed(
            '/',
          );
          Get.to(
            const LoginScreen(),
            duration: const Duration(milliseconds: 300),
            transition: Transition.leftToRightWithFade,
          );
        },
      ), */
