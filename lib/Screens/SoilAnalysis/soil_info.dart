import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Controllers/main_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Services/app_service.dart';

class SoilInfo extends StatefulWidget {
  const SoilInfo({super.key});

  @override
  State<SoilInfo> createState() => _SoilInfoState();
}

class _SoilInfoState extends State<SoilInfo> {
  FieldController fieldController = Get.find<FieldController>();
  final mainController = Get.put(MainController());
  final apiService = AppService();
  String soilInfo = '';
  String diseasePrecautions = '';
  bool detecting = false;
  bool precautionLoading = false;
  String soilType = '';
  String soilPH = '';
  String climate = '';
  String salinity = '';
  String kirecKapsami = '';
  String organicMadde = '';
  String toplamAzot = '';
  String fosfor = '';
  String kalsiyum = '';
  String magnezyum = '';
  String sodyum = '';
  String potasyum = '';
  String demir = '';
  String bakir = '';
  String cinko = '';
  String mangan = '';
  String bor = '';

  // FieldController'dan soilData'nın var olup olmadığını kontrol et

  @override
  Widget build(BuildContext context) {
    if (fieldController.soilData.value != null) {
      // soilData varsa ve içinde latitude & longitude bilgisi varsa kullan
      var soilData = fieldController.soilData.value!;
      soilType = soilData.soilStructure!;
      soilPH = soilData.soilReaction!;
      climate = soilData.climate!;
      salinity = soilData.electricalConductivity!;
      kirecKapsami = soilData.limeContent!;
      organicMadde = soilData.organicMatter!;
      toplamAzot = soilData.totalNitrogen!;
      fosfor = soilData.phosphorusContent!;
      kalsiyum = soilData.calsiyum!;
      magnezyum = soilData.magnesium!;
      sodyum = soilData.sodium!;
      potasyum = soilData.potassium!;
      demir = soilData.iron!;
      bakir = soilData.copper!;
      cinko = soilData.zinc!;
      mangan = soilData.manganese!;
      bor = soilData.boron!;
      soilInfo =
          "İklim: $climate, Toprak bünyesi: $soilType, Toprak reaksiyonu: $soilPH, Tuzluluk oranı: $salinity, Kireç kapsamı: $kirecKapsami, Organik madde: $organicMadde, Toplam Azot: $toplamAzot, Fosfor miktarı: $fosfor, Kalsiyum: $kalsiyum, Magnezyum: $magnezyum, Sodyum: $sodyum, Potasyum: $potasyum, Demir: $demir, Bakır: $bakir, Çinko: $cinko, Mangan: $mangan, Bor: $bor";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Soil Info',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: kBlackColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InfoCard(
              color: kInfoPageColor,
              tanim: 'İklim',
              aciklama: climate,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "Toprak Bünyesi",
              aciklama: soilType,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Toprak PH",
              aciklama: soilPH,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "Tuzluluk Oranı",
              aciklama: salinity,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Kireç Kapsamı",
              aciklama: kirecKapsami,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "Organik Madde",
              aciklama: organicMadde,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Toplam Azot",
              aciklama: toplamAzot,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "fosfor",
              aciklama: fosfor,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "kalsiyum",
              aciklama: kalsiyum,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "magnezyum",
              aciklama: magnezyum,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Sodyum",
              aciklama: sodyum,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "Potasyum",
              aciklama: potasyum,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Demir",
              aciklama: demir,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "Bakır",
              aciklama: bakir,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Çinko",
              aciklama: cinko,
            ),
            InfoCard(
              color: kWhiteColor,
              tanim: "Mangan",
              aciklama: mangan,
            ),
            InfoCard(
              color: kInfoPageColor,
              tanim: "Bor",
              aciklama: bor,
            ),
          ],
        ),
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
            await apiService.sendRequestForSoilAnalysis(soilInfo);
        // JSON'dan assistant'ın content kısmını al
        String assistantContent =
            diseasePrecautionsMap['choices'][0]['message']['content'];
        diseasePrecautions = json.encode(
            assistantContent); // Bu kısmı sadece assistant content olarak güncelleyin.
      }
      // Gelen içeriği göstermek için kullanın.
      _showSuccessDialog('Recommended Plant',
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
      backgroundColor: kRedColor,
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
