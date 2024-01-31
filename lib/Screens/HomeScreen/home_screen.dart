import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_image_button.dart';
import 'package:tarim_ai/Utils/CustomWidgets/small_weather_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Center(child: Text('TarımAI')),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authService.signOut(context);
              // ignore: use_build_context_synchronously
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Container(
            color: kWhiteColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  fieldSelectionButton(),
                  ImageButton(
                    backgroundColor: klightGreenColor,
                    onPressed: () {},
                    image: const AssetImage('assets/Agri_Grow_Logo.png'),
                  ),
                ],
              ),
            ),
          ),
          const SmallWeatherApp(),
        ],
      ),
    );
  }

  TextButton fieldSelectionButton() {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all<Size>(
          const Size(
              325.0, 50.0), // Genişlik ve yükseklik değerlerini ayarlayın
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
            klightGreenColor), // Düğmenin arka plan rengi
        foregroundColor: MaterialStateProperty.all<Color>(
            Colors.white), // Düğmenin metin rengi
        // textStyle: MaterialStateProperty.all<TextStyle>(
        //   const TextStyle(fontSize: 16.0), // Düğmenin metin boyutu
        // ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 16.0), // Düğmenin iç içe boşluğu
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)), // Düğmenin şekli
        ),
      ),
      child: Row(
        children: [
          const Expanded(child: Text('Custom TextButton')),
          GestureDetector(child: const Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}
