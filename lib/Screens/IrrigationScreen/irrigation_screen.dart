import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/IrrigationScreen/field_info.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Services/app_service.dart'; // FieldController import edildi

class IrrigationScreen extends StatefulWidget {
  const IrrigationScreen({Key? key}) : super(key: key);

  @override
  State<IrrigationScreen> createState() => _IrrigationScreenState();
}

class _IrrigationScreenState extends State<IrrigationScreen> {
  TextEditingController productNameController = TextEditingController();
  final apiService = AppService();
  String fieldInfo = '';
  String diseasePrecautions = '';
  bool detecting = false;
  bool precautionLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Irrigation Assistant',
          style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: kWhiteColor),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/product.jpg',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              'What plant is in the field?',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Add Product'),
                      content: TextFormField(
                        controller: productNameController,
                        decoration: const InputDecoration(
                          hintText: 'Enter product name',
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // İptal butonu işlemleri
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Onay butonu işlemleri
                            // TextFormField'dan alınan veriyi kullanabilirsiniz
                            String productName = productNameController.text;
                            // FieldController'a erişim ve productName'i güncelleme
                            FieldController fieldController =
                                Get.find<FieldController>();
                            fieldController.setProduct(productName);
                            Get.to(() => const FieldInfo());
                          },
                          child: const Text('Add'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(kGreenColor),
                minimumSize:
                    MaterialStateProperty.all<Size>(const Size(250, 50)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.all(10)),
              ),
              child: const Text(
                'ADD PLANT',
                style: TextStyle(fontSize: 18, color: kWhiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
