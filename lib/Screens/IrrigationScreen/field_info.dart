import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Controllers/main_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Services/app_service.dart';

class FieldInfo extends StatefulWidget {
  const FieldInfo({super.key});

  @override
  State<FieldInfo> createState() => _FieldInfoState();
}

class _FieldInfoState extends State<FieldInfo> {
  FieldController fieldController = Get.find<FieldController>();
  final mainController = Get.put(MainController());
  final apiService = AppService();
  String fieldInfo =
      "Bitki Türü: Kiraz, Toprak Tipi: Ağır killi, Toprak pH: Hafif alkali, İklim: Nemli kıtasal, Hava Durumu: Yağmurlu, Sıcaklık: 21°C, Rüzgar Hızı: 3.5 m/s, Nem Oranı: %68, Bulutluluk Oranı: %75, Basınç: 1014 hPa";
  String diseasePrecautions = '';
  bool detecting = false;
  bool precautionLoading = false;

  // FieldController'dan soilData'nın var olup olmadığını kontrol et

  @override
  Widget build(BuildContext context) {
    String soilType = '';
    String soilPH = '';
    String climate = '';
    if (fieldController.soilData.value != null) {
      // soilData varsa ve içinde latitude & longitude bilgisi varsa kullan
      var soilData = fieldController.soilData.value!;
      soilType = soilData.soilStructure!;
      soilPH = soilData.soilReaction!;
      climate = soilData.climate!;
    }

    String productName = fieldController.productName.value ?? "";
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
            aciklama: soilType,
          ),
          InfoCard(
            color: kInfoPageColor,
            tanim: "Toprak PH",
            aciklama: soilPH,
          ),
          InfoCard(
            color: kWhiteColor,
            tanim: "İklim",
            aciklama: climate,
          ),
          const InfoCard(
            color: kInfoPageColor,
            tanim: "Hava Durumu",
            aciklama: 'Clouds',
          ),
          const InfoCard(
            color: kWhiteColor,
            tanim: "Sıcaklık",
            aciklama: "11°",
          ),
          const InfoCard(
            color: kInfoPageColor,
            tanim: "Rüzgar Hızı",
            aciklama: "1.82 m/s",
          ),
          const InfoCard(
            color: kWhiteColor,
            tanim: "Nem Oranı",
            aciklama: "%64",
          ),
          const InfoCard(
            color: kInfoPageColor,
            tanim: "Bulutluluk Oranı",
            aciklama: "%96",
          ),
          const InfoCard(
            color: kWhiteColor,
            tanim: "Basınç",
            aciklama: "1016 hPa",
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 12.0),
        child: CustomTextButton(
          onPress: showPrecautions, // showPrecautions fonksiyonunu bağlayın
        ),
      ),
    );
  }

  void showPrecautions() async {
    setState(() {
      precautionLoading = true;
    });
    try {
      Map<String, dynamic> diseasePrecautionsMap;
      if (diseasePrecautions == '') {
        diseasePrecautionsMap =
            await apiService.sendRequestForIrrigation(fieldInfo);
        // JSON'dan assistant'ın content kısmını al
        String assistantContent =
            diseasePrecautionsMap['choices'][0]['message']['content'];
        diseasePrecautions = json.encode(
            assistantContent); // Bu kısmı sadece assistant content olarak güncelleyin.
      }
      // Gelen içeriği göstermek için kullanın.
      _showSuccessDialog('Irrigation Plan',
          diseasePrecautions); // Başlıkta 'Recommended Plant' kullanabilirsiniz.
    } catch (error) {
      _showErrorSnackBar(error);
    } finally {
      setState(() {
        precautionLoading = false;
      });
    }
  }

  void _showErrorSnackBar(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(error.toString()),
      backgroundColor: Colors.red,
    ));
  }

  void _showSuccessDialog(String title, String content) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: title,
      desc: content,
      btnOkText: 'Got it',
      btnOkColor: themeColor,
      btnOkOnPress: () {},
    ).show();
  }
}

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPress; // Parametre olarak bir fonksiyon tanımlayın

  const CustomTextButton({
    super.key,
    required this.onPress, // Kurucuda parametre olarak alın
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kGreenColor),
        minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(10)),
      ),
      child: const Text(
        'SUBMIT',
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
