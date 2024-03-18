import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/list_fields_screen.dart';
import 'package:tarim_ai/Screens/SelectedFieldScreen/selected_field_screen.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_image_button.dart';
import 'package:tarim_ai/Utils/CustomWidgets/small_weather_app.dart';

// SmallCard ve LargeCard widget tanımlamalarınızı buraya ekleyin...

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
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () async {
              await authService.signOut(context);
            },
          ),
        ],
      ),
      drawer: buildDrawer(),
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
        ],
      ),
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 100, 177, 100),
            ),
            child: Text(
              'Kullanıcı Adı',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Ana Sayfa'),
            onTap: () {
              // Ana sayfaya git
            },
          ),
          ListTile(
            title: const Text('Profil'),
            onTap: () {
              // Profil sayfasına git
            },
          ),
          ListTile(
            title: const Text('Ayarlar'),
            onTap: () {
              // Ayarlar sayfasına git
            },
          ),
          ListTile(
            title: const Text('Çıkış'),
            onTap: () {
              // Uygulamadan çıkış yap
            },
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
}
