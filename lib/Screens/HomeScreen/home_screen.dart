import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/list_fields_screen.dart';
import 'package:tarim_ai/Screens/InsectDetectionScreen/insect_detection_screen.dart';
import 'package:tarim_ai/Screens/IrrigationScreen/irrigation_screen.dart';
import 'package:tarim_ai/Screens/SelectedFieldScreen/selected_field_screen.dart';
import 'package:tarim_ai/Screens/SoilAnalysis/soil_info.dart';
import 'package:tarim_ai/Screens/WeedDetectionScreen.dart/weed_detection_screen.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_image_button.dart';
import 'package:tarim_ai/Utils/CustomWidgets/drawer_widget.dart';
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
        title: const Text(
          'TarımAI',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info_rounded,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const DrawerWidget(),
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
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SmallWeatherApp(),
          ),
          Expanded(
            child: buildCardGrid(),
          ),
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
            decoration: BoxDecoration(color: kGreenColor),
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
            onTap: () async {
              await authService.signOut(context);
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
          fieldController.selectedFieldName.value ?? 'Select Field';
      return TextButton(
        onPressed: () {
          Get.to(() => const SelectedField());
        },
        style: ButtonStyle(
          fixedSize: WidgetStateProperty.all<Size>(
            Size(MediaQuery.of(context).size.width * 0.8, 50.0),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(
              klightGreenColor), // Düğmenin arka plan rengi
          foregroundColor: WidgetStateProperty.all<Color>(
              kWhiteColor), // Düğmenin metin rengi

          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
                vertical: 10.0, horizontal: 16.0), // Düğmenin iç içe boşluğu
          ),
          shape: WidgetStateProperty.all<OutlinedBorder>(
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
              ),
            ),
            GestureDetector(
              child: Container(
                width: 25, // Circle's width
                height: 25, // Circle's height
                decoration: const BoxDecoration(
                  color: kGreenColor, // Circle's background color
                  shape: BoxShape.circle, // Makes the container a circle
                ),
                child: const Icon(Icons.chevron_right),
              ),
              onTap: () {
                Get.to(() => const SelectedField());
              },
            ), // No need for GestureDetector here
          ],
        ),
      );
    });
  }

  Widget buildCardGrid() {
    // Tasarıma uygun olarak kartları oluşturur
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyCard(
                  height: 110,
                  color: kSmallCardColor,
                  imageAsset: 'assets/saat.png',
                  title: 'SOIL ANALYSIS',
                  onTap: () {
                    Get.to(() => const SoilInfo());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyCard(
                  height: 160,
                  color: kLargeCardColor,
                  imageAsset: 'assets/weed.png',
                  title: 'WEED DETECTION',
                  onTap: () {
                    Get.to(() => const WeedDetectionPage());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyCard(
                  height: 130,
                  color: kSmallCardColor,
                  imageAsset: 'assets/marketing.png',
                  title: 'MARKETING',
                  onTap: () {
                    Get.to(() => const WeedDetectionPage());
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyCard(
                  height: 140,
                  color: kLargeCardColor,
                  imageAsset: 'assets/beetle.png',
                  title: 'INSECT DETECTION',
                  onTap: () {
                    Get.to(() => const InsectDetectionPage());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyCard(
                  height: 110,
                  color: kSmallCardColor,
                  imageAsset: 'assets/watering.png',
                  title: 'IRRIGATION',
                  onTap: () {
                    Get.to(() => const IrrigationScreen());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyCard(
                  height: 150,
                  color: kLargeCardColor,
                  imageAsset: 'assets/carbon_footprint.png',
                  title: 'CARBON FOOTPRINT',
                  onTap: () {
                    Get.to(() => const WeedDetectionPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyCard extends StatelessWidget {
  final double height;
  final Color color;
  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  const MyCard(
      {Key? key,
      required this.height,
      required this.color,
      required this.imageAsset,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              25), // Kenarları oval yapar, istediğiniz yuvarlaklık derecesini buradan ayarlayabilirsiniz
        ),
        child: SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width * 0.6,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageAsset,
                width: 50, // Örnek bir genişlik
                height: 50, // Örnek bir yükseklik
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
