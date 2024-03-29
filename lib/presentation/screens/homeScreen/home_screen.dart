import 'package:fablearner_app/exports/common_exports.dart';
import 'package:fablearner_app/exports/presentation_exports.dart';
import 'package:fablearner_app/presentation/screens/homeScreen/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  const HomeScreen({Key? key, required this.token}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedTabIndex = 0;
  late AppController appController;

  @override
  void initState() {
    super.initState();
    appController = Get.put(AppController(token: widget.token));
  }

  @override
  void dispose() {
    Get.delete<AppController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      // List of pages to be shown in the body of the screen
      CoursesScreen(appController: appController, token: widget.token),
      QrScanner(token: widget.token),
      const NotificationScreen()
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: const HomeDrawer(),
        backgroundColor: darkBlue,
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

  CustomAppBar? _buildAppBar() {
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
        return null;
      default:
        throw Exception('Invalid tab index');
    }
  }
}
