import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final PageController pageController;
  final Function(int) onItemTapped;

  const MyBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.pageController,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kGreenColor,
      currentIndex: selectedIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: '',
        ),
      ],
    );
  }
}
