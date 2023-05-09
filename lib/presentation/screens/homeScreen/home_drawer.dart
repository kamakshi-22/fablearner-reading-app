import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  HomeDrawerState createState() => HomeDrawerState();
}

class HomeDrawerState extends State<HomeDrawer> {
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
        color: darkBlue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            /* -------------------------------------------------------------------------- */
            /*                                Drawer Header                               */
            /* -------------------------------------------------------------------------- */
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height *
                  AppSizes().drawerHeaderHeight,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: lightBlue,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppSizes().drawerHeaderAvatarRadius,
                      backgroundColor: white,
                      child: Icon(
                        Icons.person_outline,
                        color: darkBlue,
                        size: AppSizes().drawerHeaderIconSize,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        _username.toUpperCase(),
                        style: AppStyles.homeDrawerUsernameTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /* -------------------------------------------------------------------------- */
            /*                            Weekly Meetings Tile                            */
            /* -------------------------------------------------------------------------- */
            ListTile(
              title: Container(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.meeting_room_outlined,
                      color: white,
                      size: AppSizes().drawerListTileIconSize,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Weekly Meetings',
                        style: AppStyles.homeDrawerListTileTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
              color: white,
              thickness: 1.0,
            ),

            /* -------------------------------------------------------------------------- */
            /*                                 Logout Tile                                */
            /* -------------------------------------------------------------------------- */
            ListTile(
              title: Container(
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      color: white,
                      size: AppSizes().drawerListTileIconSize,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Logout',
                        style: AppStyles.homeDrawerListTileTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
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
