import 'package:fablearner_app/exports/common_exports.dart';

class AppBottomNavBar extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
        size: AppSizes().bottomNavBarIconSize,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.qr_code,
        size: AppSizes().bottomNavBarIconSize,
      ),
      label: 'QR Code',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.live_help,
        size: AppSizes().bottomNavBarIconSize,
      ),
      label: 'Help Desk',
    ),
  ];

  final String token;
  final Function(int) onTabChanged; // Callback function to handle tab changes
  final int selectedTabIndex;
  AppBottomNavBar({
    Key? key,
    required this.token,
    required this.onTabChanged,
    required this.selectedTabIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height *
            (AppSizes().bottomNavBarHeight),
        child: BottomNavigationBar(
          currentIndex: selectedTabIndex,
          backgroundColor: lightBlue,
          selectedItemColor: primaryRed,
          selectedLabelStyle: AppStyles.bottomNavBarSelectedLabelTextStyle,
          unselectedItemColor: white,
          unselectedLabelStyle: AppStyles.bottomNavBarUnselectedLabelTextStyle,
          items: bottomNavBarItems,
          onTap: (int index) {
            onTabChanged(index);
          },
        ),
      ),
    );
  }
}
