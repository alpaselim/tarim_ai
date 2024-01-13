import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/functions.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/welcome_background.png'), // Arka plan resminin yolu
            fit: BoxFit.cover, // Resmi container'a sığdır
            opacity: 0.9,
          ),
        ),
        child: body(),
      ),
    );
  }

  Padding body() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // On click: Navigate to "Home Screen"
                  Navigator.pushReplacementNamed(context, loginScreenPath);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                    color: kGreenColor,
                  ),
                ),
              ),
            ],
          ),
          Image.asset('assets/group1.png'),
          Image.asset('assets/Group2.png'),
          CustomWelcomeButton(
            text: 'Start with Email',
            onPressed: () {
              // On click: Navigate to "Phone Registration"
              Navigator.pushNamed(context, '/email_reg');
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: kLightGreyColor.withOpacity(
                  0.5), // Saydamlık eklemek için renk ve opaklık değeri
            ),
            onPressed: () {
              // On click: Navigate to "Phone Registration"
              Navigator.pushNamed(context, '/email_reg');
            },
            child: const Text(
              'Start with Phone',
              style: TextStyle(
                color: kWhiteColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              functions.setIsFirstTime();
              Navigator.pushNamed(context, loginScreenPath);
            },
            //Texti ayırarak Sadece 'sign in' in altını çizmek için.
            child: RichText(
              text: const TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: kWhiteColor,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      decoration:
                          TextDecoration.underline, // Altını çizmek için
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
