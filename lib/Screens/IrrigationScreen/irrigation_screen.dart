import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/IrrigationScreen/field_info.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Services/app_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_buttom_app_bar.dart'; // FieldController import edildi

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
      /* extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kGreenColor,
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        child: const Icon(Icons.camera_alt),
      ),
      bottomNavigationBar: const CustomButtomAppBar(), */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/product.png',
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
