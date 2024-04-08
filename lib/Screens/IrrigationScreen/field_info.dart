import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Controllers/main_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';

class FieldInfo extends StatefulWidget {
  const FieldInfo({super.key});

  @override
  State<FieldInfo> createState() => _FieldInfoState();
}

class _FieldInfoState extends State<FieldInfo> {
  FieldController fieldController = Get.find<FieldController>();
  final mainController = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    String productName = fieldController.productName.value ?? "";
    var currentWeather = mainController.currentWeatherData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Field Info',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: kBlackColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InfoCard(
            color: kInfoPageColor,
            tanim: 'Bitki türü',
            aciklama: productName,
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "Toprak Tipi",
            aciklama: productName,
          ),
          InfoCard(
            color: kInfoPageColor,
            tanim: "Toprak PH",
            aciklama: productName,
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "İklim",
            aciklama: productName,
          ),
          InfoCard(
            color: kInfoPageColor,
            tanim: "Hava Durumu",
            aciklama: currentWeather.toString(),
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "Sıcaklık",
            aciklama: "",
          ),
          InfoCard(
            color: kInfoPageColor,
            tanim: "Rüzgar Hızı",
            aciklama: productName,
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "Nem Oranı",
            aciklama: productName,
          ),
          InfoCard(
            color: kInfoPageColor,
            tanim: "Bulutluluk Durumu",
            aciklama: productName,
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "Yağış Miktarı",
            aciklama: productName,
          ),
          InfoCard(
            color: kInfoPageColor,
            tanim: "Bulutluluk Durumu",
            aciklama: productName,
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "Yağış Miktarı",
            aciklama: productName,
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(40.0, 0, 40, 12.0),
        child: CustomTextButton(),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kGreenColor),
        minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(10)),
      ),
      child: const Text(
        'ADD PLANT',
        style: TextStyle(fontSize: 18, color: kWhiteColor),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final Color color;
  final String tanim;
  final String aciklama;
  const InfoCard({
    super.key,
    required this.color,
    required this.tanim,
    required this.aciklama,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 0, 12, 0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6), // Kenar yarıçapını ayarlayın
        ),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '$tanim:',
                  style: const TextStyle(color: kBoldGreenColor, fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: Text(
                  aciklama,
                  style: const TextStyle(
                      color: kBoldGreenColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
