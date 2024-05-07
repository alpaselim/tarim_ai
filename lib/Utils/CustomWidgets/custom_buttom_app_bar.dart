import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/HomeScreen/home_screen.dart';
import 'package:tarim_ai/Screens/UserScreen/user_screen.dart';

class CustomButtomAppBar extends StatefulWidget {
  const CustomButtomAppBar({
    super.key,
  });

  @override
  State<CustomButtomAppBar> createState() => _CustomButtomAppBarState();
}

class _CustomButtomAppBarState extends State<CustomButtomAppBar> {
  Color _homeButtonColor = kWhiteColor;
  Color _userButtonColor = kWhiteColor;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      height: 45,
      color: kGreenColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
            ),
            color: _homeButtonColor,
            onPressed: () {
              setState(() {
                _homeButtonColor = kWhiteColor; // Tıklandığında rengi değiştir
                _userButtonColor = kBlackColor; // Diğer butonun rengini sıfırla
              });
              Get.to(() => const HomeScreen());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outlined,
            ),
            color: _userButtonColor,
            onPressed: () {
              setState(() {
                _userButtonColor = kWhiteColor; // Tıklandığında rengi değiştir
                _homeButtonColor = kBlackColor; // Diğer butonun rengini sıfırla
              });
              Get.to(() => const UserScreen());
            },
          ),
        ],
      ),
    );
  }
}























/* import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/HomeScreen/home_screen.dart';
import 'package:tarim_ai/Screens/UserScreen/user_screen.dart';

class CustomButtomAppBar extends StatefulWidget {
  const CustomButtomAppBar({
    super.key,
  });

  @override
  State<CustomButtomAppBar> createState() => _CustomButtomAppBarState();
}

class _CustomButtomAppBarState extends State<CustomButtomAppBar> {
  Color _homeButtonColor = kWhiteColor;
  Color _userButtonColor = kWhiteColor;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      height: 45,
      color: kGreenColor,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
            ),
            color: _homeButtonColor,
            onPressed: () {
              setState(() {
                _homeButtonColor = kWhiteColor; // Tıklandığında rengi değiştir
                _userButtonColor = kBlackColor; // Diğer butonun rengini sıfırla
              });
              Get.to(() => const HomeScreen());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outlined,
            ),
            color: _userButtonColor,
            onPressed: () {
              setState(() {
                _userButtonColor = kWhiteColor; // Tıklandığında rengi değiştir
                _homeButtonColor = kBlackColor; // Diğer butonun rengini sıfırla
              });
              Get.to(() => const UserScreen());
            },
          ),
        ],
      ),
    );
  }
}

 */