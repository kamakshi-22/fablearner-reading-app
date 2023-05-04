import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/presentation/screens/homeScreen/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appController = Get.put(AppController(token: widget.token));
    print('Loaded Courses ${appController.courseList.length}');
    List<Widget> pages = [
      // Create a list of pages to be shown in the body of the screen
      CoursesScreen(appController: appController, token: widget.token),
      QrScanner(token: widget.token),
      HelpDesk(),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: const HomeDrawer(),
        backgroundColor: secondaryColor,
        body: pages[_selectedTabIndex],
        bottomNavigationBar: AppBottomNavBar(
          token: widget.token,
          onTabChanged: (int index) {
            setState(() {
              _selectedTabIndex = index;
            });
          },
          selectedTabIndex: _selectedTabIndex,
        ),
      ),
    );
  }

  CustomAppBar _buildAppBar() {
    switch (_selectedTabIndex) {
      case 0:
        return coursesAppBar(
          token: widget.token,
          context: context,
        );
      case 1:
        return const CustomAppBar(
          title: 'QR Scanner',
          centerTitle: false,
          showBackButton: false,
        );
      case 2:
        return const CustomAppBar(
          title: 'Help Desk',
          centerTitle: false,
          showBackButton: false,
        );
      default:
        throw Exception('Invalid tab index');
    }
  }
}
