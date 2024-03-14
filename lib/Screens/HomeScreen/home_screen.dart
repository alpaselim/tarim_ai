import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/list_fields_screen.dart';
import 'package:tarim_ai/Screens/SelectedFieldScreen/selected_field_screen.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_image_button.dart';
import 'package:tarim_ai/Utils/CustomWidgets/small_weather_app.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart'; // Import your model

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FieldController fieldController = Get.find<FieldController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Center(
            child: Text(
          'TarımAI',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: kWhiteColor),
        )),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authService.signOut(context);
            },
          ),
        ],
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          Container(
            color: kGreenColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  fieldSelectionButton(),
                  ImageButton(
                    backgroundColor: klightGreenColor,
                    onPressed: () {
                      Get.to(() => const ListFields());
                    },
                    image: const AssetImage('assets/Agri_Grow_Logo.png'),
                  ),
                ],
              ),
            ),
          ),
          const SmallWeatherApp(),
          Expanded(
            child: soilAnalysisDetails(),
          ),
        ],
      ),
    );
  }

  Widget fieldSelectionButton() {
    // Use GetBuilder or Obx to listen for changes
    return Obx(() {
      // Use the controller's selectedFieldName to display the name
      String buttonText =
          fieldController.selectedFieldName.value ?? 'Select a Field';
      return TextButton(
        onPressed: () {
          Get.to(() => const SelectedField());
        },
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
            Expanded(
                child: Text(
              buttonText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            )),
            const Icon(Icons.chevron_right), // No need for GestureDetector here
          ],
        ),
      );
    });
  }

  Widget soilAnalysisDetails() {
    return Obx(() {
      SoilAnalysis? soilData = fieldController.soilData.value;
      if (soilData == null) {
        return const Text("No soil data selected.");
      } else {
        // Assuming your SoilAnalysis model has properties like pH, nitrogen, etc.
        return ListView(
          children: [
            ListTile(
              title: const Text("Tarla id"),
              subtitle: Text(soilData.fieldId.toString()),
            ),
            ListTile(
              title: const Text("Latitude"),
              subtitle: Text(soilData.latitude.toString()),
            ),
            ListTile(
              title: const Text("longitude"),
              subtitle: Text(soilData.longitude.toString()),
            ),
            ListTile(
              title: const Text("Tarla id"),
              subtitle: Text(soilData.fieldId.toString()),
            ),

            ListTile(
              title: const Text("Tarla adı"),
              subtitle: Text(soilData.fieldName.toString()),
            ),
            ListTile(
              title: const Text("Toprak bünyesi"),
              subtitle: Text(soilData.soilStructure.toString()),
            ),
            ListTile(
              title: const Text("Nitrogen"),
              subtitle: Text(soilData.totalNitrogen.toString()),
            ),
            ListTile(
              title: const Text("Phosphorus"),
              subtitle: Text(soilData.phosphorusContent.toString()),
            ),
            ListTile(
              title: const Text("Potassium"),
              subtitle: Text(soilData.potassium.toString()),
            ),
            // Add more ListTiles for each property in your SoilAnalysis model
          ],
        );
      }
    });
  }
}







 

 /*   import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/list_fields_screen.dart';
import 'package:tarim_ai/Screens/SelectedFieldScreen/selected_field_screen.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_image_button.dart';
import 'package:tarim_ai/Utils/CustomWidgets/small_weather_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FieldController fieldController = Get.find<FieldController>();

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
                  fieldSelectionButton(), // Update this method to use GetX
                  ImageButton(
                    backgroundColor: klightGreenColor,
                    onPressed: () {
                      Get.to(() => const ListFields());
                    },
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

  Widget fieldSelectionButton() {
    // Use GetBuilder or Obx to listen for changes
    return Obx(() {
      // Use the controller's selectedFieldName to display the name
      String buttonText =
          fieldController.selectedFieldName.value ?? 'Select a Field';
      return TextButton(
        onPressed: () {
          Get.to(() => const SelectedField());
        },
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
            Expanded(child: Text(buttonText)),
            const Icon(Icons.chevron_right), // No need for GestureDetector here
          ],
        ),
      );
    });
  }
} */