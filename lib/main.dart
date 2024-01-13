import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/HomeScreen/home_screen.dart';
import 'package:tarim_ai/Screens/LoginScreen/login_screen.dart';
import 'package:tarim_ai/Screens/SignUpScreen/signup_screen.dart';
import 'package:tarim_ai/Screens/SplashScreen/splash_screen.dart';
import 'package:tarim_ai/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:tarim_ai/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stock App',
      theme: appTheme,
      getPages: getPages,
      initialRoute: splashScreenPath,
    );
  }
}

List<GetPage<dynamic>>? getPages = [
  GetPage(
    name: welcomeScreenPath,
    page: () => const WelcomeScreen(),
  ),
  GetPage(
    name: splashScreenPath,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: loginScreenPath,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: signUpScreenPath,
    page: () => const SignUpScreen(),
  ),
  GetPage(
    name: homeScreenPath,
    page: () => const HomeScreen(),
  ),
];
