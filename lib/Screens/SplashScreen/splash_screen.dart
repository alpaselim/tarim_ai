import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      //Uygulamanin ilkkez calisip calismadigini kontrol eder
      functions.checkIsFirstTime().then((isFirstTime) {
        if (isFirstTime) {
          Navigator.pushReplacementNamed(context, welcomeScreenPath);
        } else {
          // FirebaseAuth.instance.currentUser ile mevcut kullanıcıyı kontrol etme
          User? user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            // Navigator ile Welcome Screen'a geçiş
            Navigator.pushReplacementNamed(context, loginScreenPath);
          } else {
            // Kullanıcı oturum açmışsa, ana ekrana yönlendir
            Navigator.pushReplacementNamed(context, homeScreenPath);
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSplashBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Agri_Grow_Logo.png', width: 200, height: 200),
            const SizedBox(height: 10),
            Image.asset('assets/AgriGrow.png', width: 166, height: 41),
            const SizedBox(height: 10),
            const Text(
              'Farmer Friendly App',
              style: TextStyle(color: kWhiteColor, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
