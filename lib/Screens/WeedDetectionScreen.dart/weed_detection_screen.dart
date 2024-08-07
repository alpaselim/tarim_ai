import 'dart:convert';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Services/app_service.dart';
import 'package:tarim_ai/Services/snackbar_service.dart';

class WeedDetectionPage extends StatefulWidget {
  const WeedDetectionPage({super.key});

  @override
  State<WeedDetectionPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WeedDetectionPage> {
  final apiService = AppService();
  File? _selectedImage;
  String weedName = '';
  String diseasePrecautions = '';
  bool detecting = false;
  bool precautionLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  detectDisease() async {
    setState(() {
      detecting = true;
    });
    try {
      weedName =
          await apiService.sendImageToGPT4VisionForWeed(image: _selectedImage!);
    } catch (error) {
      snackbarService.showWarningSnackBar(error.toString());
    } finally {
      setState(() {
        detecting = false;
      });
    }
  }

  void showPrecautions() async {
    setState(() {
      precautionLoading = true;
    });
    try {
      Map<String, dynamic> diseasePrecautionsMap;
      if (diseasePrecautions == '') {
        diseasePrecautionsMap = await apiService.sendRequestForWeed(weedName);
        // JSON'dan assistant'ın content kısmını al
        String assistantContent =
            diseasePrecautionsMap['choices'][0]['message']['content'];
        diseasePrecautions = json.encode(
            assistantContent); // Bu kısmı sadece assistant content olarak güncelleyin.
      }
      // Gelen içeriği göstermek için kullanın.
      _showSuccessDialog(weedName,
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
      btnOkColor: kThemeColor,
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    // Top right corner
                    bottomLeft: Radius.circular(50.0), // Bottom right corner
                  ),
                  color: kThemeColor,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ksoftGreenColor,
                  borderRadius: const BorderRadius.only(
                    // Top right corner
                    bottomLeft: Radius.circular(50.0), // Bottom right corner
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      // Shadow color with some transparency
                      spreadRadius: 1,
                      // Extend the shadow to all sides equally
                      blurRadius: 5,
                      // Soften the shadow
                      offset: const Offset(2, 2), // Position of the shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        _pickImage(ImageSource.gallery);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreenColor,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'OPEN GALLERY',
                            style: TextStyle(color: kWhiteColor),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.image,
                            color: kWhiteColor,
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _pickImage(ImageSource.camera);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreenColor,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('START CAMERA',
                              style: TextStyle(color: kWhiteColor)),
                          SizedBox(width: 10),
                          Icon(Icons.camera_alt, color: kWhiteColor)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          _selectedImage == null
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset('assets/weed_detection.png'),
                )
              : Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
          if (_selectedImage != null)
            detecting
                ? const SpinKitWave(
                    color: kThemeColor,
                    size: 30,
                  )
                : Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(bottom: 60, left: 20, right: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kThemeColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 15),
                        // Set some horizontal and vertical padding
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                      ),
                      onPressed: () {
                        detectDisease();
                      },
                      child: const Text(
                        'DETECT',
                        style: TextStyle(
                          color: Colors.white, // Set the text color to white
                          fontSize: 16, // Set the font size
                          fontWeight:
                              FontWeight.bold, // Set the font weight to bold
                        ),
                      ),
                    ),
                  ),
          if (weedName != '')
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextStyle(
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16),
                        child: AnimatedTextKit(
                            isRepeatingAnimation: false,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            totalRepeatCount: 1,
                            animatedTexts: [
                              TyperAnimatedText(
                                weedName.trim(),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
                precautionLoading
                    ? const SpinKitWave(
                        color: Colors.blue,
                        size: 30,
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                        ),
                        onPressed: () {
                          showPrecautions();
                        },
                        child: const Text(
                          'PRECAUTION',
                          style: TextStyle(
                            color: kWhiteColor,
                          ),
                        ),
                      ),
              ],
            ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
