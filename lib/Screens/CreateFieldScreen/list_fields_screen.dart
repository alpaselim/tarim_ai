import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/map_sample.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class ListFields extends StatefulWidget {
  const ListFields({Key? key}) : super(key: key);

  @override
  State<ListFields> createState() => _ListFieldsState();
}

class _ListFieldsState extends State<ListFields> {
  // Global TextEditingController for the edit dialog
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksoftGreenColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text(
          'Manage Fields',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            color: kWhiteColor,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<SoilAnalysis>>(
        stream: StreamService().getCurrentUserFields(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Bir hata oluştu: ${snapshot.error}');
          }
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final fields = snapshot.data!.docs.map((doc) => doc.data()).toList();
          return ListView.builder(
            itemCount: fields.length,
            itemBuilder: (context, index) {
              final field = fields[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.text = field.fieldName ?? "";
                    showDialogMethod(context, snapshot, index);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10.0), // Dairenin yarı çapı
                    ),
                  ),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: klightGreenColor,
                      backgroundImage: AssetImage('assets/Agri_Grow_Logo.png'),
                    ),
                    title: Text(field.fieldName ?? "Bilinmeyen Tarla"),
                    trailing: PopupMenuButton<String>(
                      onSelected: (String result) {
                        if (result == 'delete') {
                          // Tarla silme işlemi
                          final String fieldId = snapshot.data!.docs[index].id;
                          fireStoreService
                              .deleteFieldFromCurrentUser(fieldId)
                              .then((_) {
                            // Başarılı silme işlemi sonrası ek işlemler yapılabilir.
                          }).catchError((error) {
                            // Hata yönetimi
                          });
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20,
                              ), // Delete simgesi
                              SizedBox(width: 8), // Boşluk
                              Text('Delete'), // Delete metni
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const MapSmple());
        },
        backgroundColor: kGreenColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> showDialogMethod(BuildContext context,
      AsyncSnapshot<QuerySnapshot<SoilAnalysis>> snapshot, int index) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Edit Field',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          content: TextFormField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Enter field name',
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
                      color: const Color.fromARGB(255, 133, 134, 136),
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
                        // Add butonu işlemleri
                        // Değişiklikleri kaydet
                        /*  Get.find<FieldController>()
                                                                        .updateFieldName(controller.text); */
                        final String fieldId = snapshot.data!.docs[index].id;
                        fireStoreService
                            .updateFieldName(fieldId, controller.text)
                            .then((_) {
                          Navigator.of(context).pop();
                        }).catchError((error) {
                          // Hata yönetimi
                        });
                      },
                      child: const Text('Save',
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
            borderRadius:
                BorderRadius.circular(30), // Kenar yuvarlaklığını ayarla
          ),
        );
      },
    );
  }
}
