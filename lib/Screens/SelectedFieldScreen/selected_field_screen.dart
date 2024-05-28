import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/field_controller.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class SelectedField extends StatefulWidget {
  const SelectedField({super.key});

  @override
  State<SelectedField> createState() => _SelectedFieldState();
}

class _SelectedFieldState extends State<SelectedField> {
  final FieldController fieldController = Get.find<FieldController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksoftGreenColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text(
          'Select Field',
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
          final fields = snapshot.data!.docs;
          return ListView.builder(
            itemCount: fields.length,
            itemBuilder: (context, index) {
              final doc = fields[index];
              return Obx(() => Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: klightGreenColor,
                        backgroundImage:
                            AssetImage('assets/Agri_Grow_Logo.png'),
                      ),
                      title: Text(doc.data().fieldName ?? "Bilinmeyen Tarla"),
                      trailing: doc.id == fieldController.selectedFieldId.value
                          ? const Icon(Icons.radio_button_checked)
                          : const Icon(Icons.radio_button_unchecked),
                      onTap: () {
                        if (doc.id == fieldController.selectedFieldId.value) {
                          fieldController.clearSelection();
                        } else {
                          fieldController.selectField(
                              doc.id, doc.data().fieldName, doc.data());
                        }
                      },
                    ),
                  ));
            },
          );
        },
      ),
    );
  }
}
