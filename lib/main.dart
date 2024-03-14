import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Controllers/location_controller.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/create_field_screen.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/map_bar.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/map_sample.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/map_screen.dart';
import 'package:tarim_ai/Screens/HomeScreen/home_screen.dart';
import 'package:tarim_ai/Screens/LoginScreen/login_screen.dart';
import 'package:tarim_ai/Screens/SelectedFieldScreen/selected_field_screen.dart';
import 'package:tarim_ai/Screens/SignUpScreen/signup_screen.dart';
import 'package:tarim_ai/Screens/SplashScreen/splash_screen.dart';
import 'package:tarim_ai/Screens/WelcomeScreen/welcome_screen.dart';
import 'package:tarim_ai/Utils/CustomWidgets/weather_app.dart';
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
    Get.put(LocationController());
    Get.put(FieldController());
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
  GetPage(
    name: weatherAppPath,
    page: () => const WeatherApp(),
  ),
  GetPage(
    name: mapSamplePath,
    page: () => const MapSample(),
  ),
  GetPage(
    name: mapSmplePath,
    page: () => const MapSmple(),
  ),
  GetPage(
    name: mapBarPath,
    page: () => const MapBar(),
  ),
  GetPage(
    name: createFieldPath,
    page: () => const CreateField(),
  ),
  GetPage(
    name: selectedFieldPath,
    page: () => const SelectedField(),
  ),
];
