import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _username = '';
  int _selectedIndex = 0;

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
      child: Container(
        color: secondaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 150.0,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: tertiaryColor,
                ),
                child: Center(
                  child: Text(
                    'Welcome, $_username!',
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: lightColor,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Meetings',
                style: TextStyle(
                  fontSize: 18.0,
                  color: lightColor,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 0; // update selected index
                });
                // Handle meetings tile tapped
                Get.to(
                  () => const Meetings(),
                  duration: const Duration(milliseconds: 600),
                  transition: Transition.leftToRight,
                );
              },
              tileColor: _selectedIndex == 0 ? Colors.red : null,
            ),
          ],
        ),
      ),
    );
  }
}
