import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/IrrigationScreen/field_info.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Services/app_service.dart';

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
        //automaticallyImplyLeading: false,
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
                      title: const Center(
                        child: Text(
                          'Add Plant',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      content: TextFormField(
                        controller: productNameController,
                        autofocus: true,
                        decoration: const InputDecoration(
                          hintText: 'Enter product name',
                          border: UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.30, // Genişlik ayarı
                                height: 40, // Yükseklik ayarı
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 133, 134, 136),
                                  //  kGreyColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel',
                                      style: TextStyle(color: kWhiteColor)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width *
                                    0.30, // Genişlik ayarı
                                height: 40, // Yükseklik ayarı
                                decoration: BoxDecoration(
                                  color: kGreenColor,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    String productName =
                                        productNameController.text;
                                    // FieldController'a erişim ve productName'i güncelleme
                                    FieldController fieldController =
                                        Get.find<FieldController>();
                                    fieldController.setProduct(productName);
                                    Get.to(() => const FieldInfo());
                                  },
                                  child: const Text('Add',
                                      style: TextStyle(color: kWhiteColor)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: kGreyColor, width: 4),
                        // Dialog şeklini belirle
                        borderRadius: BorderRadius.circular(
                            30), // Kenar yuvarlaklığını ayarla
                      ),
                    );
                  },
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(kGreenColor),
                minimumSize: WidgetStateProperty.all<Size>(const Size(250, 50)),
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
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






/* showDialog(
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
                ); */