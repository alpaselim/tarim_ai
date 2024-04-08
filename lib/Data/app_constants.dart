import 'package:flutter/material.dart';

const kWhiteColor = Colors.white;
const kSplashBackgroundColor = Color(0xFF34A853);
const kWelcomeGreyColor = Color.fromARGB(135, 253, 254, 255);
const titleTextFieldColor = Color(0xFF9796A1);
const kBlackColor = Colors.black;
const kBlueColor = Color(0xFF2372CF);
const kOrangeColor = Colors.orange;
const kOrangeLightColor = Color(0xffFE9F83);
const kGreenLightColor = Color(0xFFc0ff3e);
const kRedColor = Colors.red;
//const kGreenColor = Color(0xFF35A854);
const kGreenColor = Color.fromARGB(255, 100, 177, 100);
const kGreyColor = Colors.grey;
const kShadowColor = Color.fromRGBO(0, 0, 0, 0.25);
const kButtonGreyColor = Color(0xFF5B5B5E);
const kIconColor = Color(0xFFD0D2D1);
const kLightGreyColor = Color.fromARGB(135, 253, 254, 255);
const klightGreenColor = Color.fromARGB(255, 133, 184, 116);
const kturkuazColor = Color(0xFFE3F3F0);
const ksoftGreenColor = Color.fromARGB(255, 237, 241, 232);
const kSmallCardColor = Color.fromARGB(255, 239, 255, 219);
const kLargeCardColor = Color.fromARGB(255, 246, 255, 200);
const kInfoPageColor = Color.fromARGB(255, 209, 241, 231);
const kBoldGreenColor = Color.fromARGB(255, 42, 92, 75);
Color themeColor = const Color(0xFF5bc787);
Color textColor = Colors.white;
ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: kWhiteColor,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(
      color: kWhiteColor, size: 30, // Geri buton rengi
    ),
    titleTextStyle: TextStyle(
      color: kWhiteColor, // Başlık rengi
      fontSize: 20, // Başlık font büyüklüğü
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(color: kGreyColor),
    contentPadding: const EdgeInsets.all(12.0),
    border: customOutlineInputBorder(),
    enabledBorder: customOutlineInputBorder(),
    focusedBorder: customOutlineInputBorder(),
    disabledBorder: customOutlineInputBorder(),
    errorBorder: customErrorOutlineInputBorder(),
    focusedErrorBorder: customErrorOutlineInputBorder(),
    errorStyle: const TextStyle(height: 0),
  ),
);

OutlineInputBorder customOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: kGreenColor,
      width: 2.0,
    ),
  );
}

OutlineInputBorder customErrorOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: kRedColor,
      width: 2.0,
    ),
  );
}
