import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart';
import 'package:tarim_ai/Screens/CreateFieldScreen/map_sample.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class ListFields extends StatefulWidget {
  const ListFields({super.key});

  @override
  State<ListFields> createState() => _ListFieldsState();
}

class _ListFieldsState extends State<ListFields> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksoftGreenColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text('Manage Fields'),
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
                child: ListTile(
                  leading: const CircleAvatar(
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
                      } else if (result == 'edit') {
                        // Düzenleme işlemi
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Düzenle'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Sil'),
                      ),
                    ],
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
}
