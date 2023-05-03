import 'package:fablearner_app/constants/colors.dart';
import 'package:flutter/material.dart';

class AppBottomNavBar extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.qr_code,
      ),
      label: 'Scan QR Code',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.live_help,
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
    return BottomNavigationBar(
      currentIndex: selectedTabIndex,
      backgroundColor: primaryColor,
      selectedItemColor: lightColor,
      selectedLabelStyle: const TextStyle(color: lightColor),
      unselectedItemColor: secondaryColor,
      unselectedLabelStyle: const TextStyle(color: secondaryColor),
      items: bottomNavBarItems,
      onTap: (int index) {
        onTabChanged(index);
      },
    );
  }
}
