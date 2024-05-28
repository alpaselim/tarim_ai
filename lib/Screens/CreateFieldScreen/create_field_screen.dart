import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Controllers/location_controller.dart';
import 'package:tarim_ai/Data/app_constant_env.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/soil_analysis.dart';
import 'package:tarim_ai/Screens/HomeScreen/home.dart';
import 'package:tarim_ai/Screens/HomeScreen/home_screen.dart';
import 'package:tarim_ai/Services/firestore_service.dart';

class CreateField extends StatefulWidget {
  const CreateField({super.key});
  @override
  State<CreateField> createState() => CreateFieldState();
}

class CreateFieldState extends State<CreateField> {
  final LocationController locationController = Get.put(LocationController());
  final _formKey = GlobalKey<FormState>();

  // Form alanları için controller'lar
  final TextEditingController _fieldNameController = TextEditingController();
  String? selectedClimate;
  String? selectedSoilTexture;
  String? selectedSoilReaction;
  String? selectedElectricalConductivity;
  String? selectedLimeContent;
  String? selectedOrganicSubstance;
  String? selectedTotalNitrogen;
  String? selectedPhosphorusContent;
  String? selectedCalsiyum;
  String? selectedMagnezyum;
  String? selectedSodyum;
  String? selectedPotasyum;
  String? selectedDemir;
  String? selectedBakir;
  String? selectedCinko;
  String? selectedMangan;
  String? selectedBor;

  @override
  void dispose() {
    // Controller'ları temizleyin
    _fieldNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksoftGreenColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text('Add field'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
            onPressed: () async {
              SoilAnalysis soilAnalysis = SoilAnalysis(
                fieldName: _fieldNameController.text,
                latitude: locationController.latitude.value,
                longitude: locationController.longitude.value,
                climate: selectedClimate,
                soilStructure: selectedSoilTexture,
                soilReaction: selectedSoilReaction,
                electricalConductivity: selectedElectricalConductivity,
                limeContent: selectedLimeContent,
                organicMatter: selectedOrganicSubstance,
                totalNitrogen: selectedTotalNitrogen,
                phosphorusContent: selectedPhosphorusContent,
                calsiyum: selectedCalsiyum,
                magnesium: selectedMagnezyum,
                sodium: selectedSodyum,
                potassium: selectedPotasyum,
                iron: selectedDemir,
                copper: selectedBakir,
                zinc: selectedCinko,
                manganese: selectedMangan,
                boron: selectedBor,
              );

              await fireStoreService.addFieldToCurrentUser(soilAnalysis);

              Get.to(() => const Home());
            },
          ),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            addressTextField(),
            const SizedBox(height: 15),
            fieldNameTextField(),
            const SizedBox(height: 15),
            // İklim ve Toprak Bünyesi için Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      climateDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      soilTextureDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Toprak Reaksiyonu ve Elektriksel İletkenlik için Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      soilReactionDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      electricalConductivityDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      limeContentDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      organicSubstanceDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      totalNitrogenDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      phosphorusContentDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Center(
              child: titleTextField(
                  "Katyonlar", kBlackColor, 16.0, FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      calsiyumDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      magnezyumDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sodyumDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      potasyumDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Center(
              child: titleTextField(
                  "Mikroelementler", kBlackColor, 16.0, FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      demirDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bakirDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cinkoDropdownFormField(),
                    ],
                  ),
                ),
                const SizedBox(width: 10), // İki Dropdown arasında boşluk
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      manganDropdownFormField(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      borDropdownFormField(),
                    ],
                  ),
                ),
                const Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Text titleTextField(
      String text, Color myColor, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: myColor,
      ),
    );
  }

  Container fieldNameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: ksoftGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
            labelText: 'Tarla Adı', labelStyle: TextStyle(fontSize: 14)),
        controller: _fieldNameController,
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        style: const TextStyle(color: kBlackColor),
      ),
    );
  }

  Container addressTextField() {
    return Container(
      decoration: BoxDecoration(
        color: ksoftGreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.room,
            size: 35,
            color: kRedColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Obx(() => Text(
                  locationController.address.value,
                  style: const TextStyle(fontSize: 16),
                )),
          ),
        ],
      ),
    );
  }

  // iklim seçimi
  DropdownButtonFormField<String> climateDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'İklim', labelStyle: TextStyle(fontSize: 14)),
      value: selectedClimate,
      items: climate.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 13,
            ),
            //overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedClimate = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return climate.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
          );
        }).toList();
      },
    );
  }

  // Toprak Bunyesi secimi
  DropdownButtonFormField<String> soilTextureDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Toprak Bünyesi', labelStyle: TextStyle(fontSize: 14)),
      value: selectedSoilTexture,
      items: soilTexture.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedSoilTexture = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return soilTexture.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  // Toprak PH bilgisi secimi
  DropdownButtonFormField<String> soilReactionDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Toprak Reaksiyonu', labelStyle: TextStyle(fontSize: 14)),
      value: selectedSoilReaction,
      items: soilReaction.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedSoilReaction = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return soilReaction.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  // Toprak Tuzluluk secimi
  DropdownButtonFormField<String> electricalConductivityDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Elektriksel İletkenlik',
          labelStyle: TextStyle(fontSize: 14)),
      value: selectedElectricalConductivity,
      items: electricalConductivity.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedElectricalConductivity = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return electricalConductivity.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> limeContentDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Kireç Kapsamı', labelStyle: TextStyle(fontSize: 14)),
      value: selectedLimeContent,
      items: limeContent.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedLimeContent = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return limeContent.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  // Organik maddde miktarı seçimi
  DropdownButtonFormField<String> organicSubstanceDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Organik Madde', labelStyle: TextStyle(fontSize: 14)),
      value: selectedOrganicSubstance,
      items: organicSubstance.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedOrganicSubstance = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return organicSubstance.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  // Toplam Azot miktarı secimi
  DropdownButtonFormField<String> totalNitrogenDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Toplam Azot', labelStyle: TextStyle(fontSize: 14)),
      value: selectedTotalNitrogen,
      items: totalNitrogen.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedTotalNitrogen = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return totalNitrogen.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> phosphorusContentDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Fosfor Miktarı', labelStyle: TextStyle(fontSize: 14)),
      value: selectedPhosphorusContent,
      items: phosphorusContent.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedPhosphorusContent = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return phosphorusContent.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> calsiyumDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Kalsiyum', labelStyle: TextStyle(fontSize: 14)),
      value: selectedCalsiyum,
      items: calsiyum.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedCalsiyum = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return calsiyum.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> magnezyumDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Magnezyum', labelStyle: TextStyle(fontSize: 14)),
      value: selectedMagnezyum,
      items: magnezyum.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedMagnezyum = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return magnezyum.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> sodyumDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Sodyum', labelStyle: TextStyle(fontSize: 14)),
      value: selectedSodyum,
      items: sodyum.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedSodyum = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return sodyum.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> potasyumDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Potasyum ', labelStyle: TextStyle(fontSize: 14)),
      value: selectedPotasyum,
      items: potasyum.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedPotasyum = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return potasyum.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> demirDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Demir', labelStyle: TextStyle(fontSize: 14)),
      value: selectedDemir,
      items: demir.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedDemir = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return demir.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> bakirDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Bakir', labelStyle: TextStyle(fontSize: 14)),
      value: selectedBakir,
      items: bakir.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedBakir = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return bakir.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> cinkoDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Cinko', labelStyle: TextStyle(fontSize: 14)),
      value: selectedCinko,
      items: cinko.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedCinko = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return cinko.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> manganDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Mangan', labelStyle: TextStyle(fontSize: 14)),
      value: selectedMangan,
      items: mangan.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedMangan = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return mangan.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }

  DropdownButtonFormField<String> borDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
          labelText: 'Bor', labelStyle: TextStyle(fontSize: 14)),
      value: selectedBor,
      items: bor.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          selectedBor = newValue;
        });
      },
      selectedItemBuilder: (BuildContext context) {
        return potasyum.map((String value) {
          return Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 15,
            ),
          );
        }).toList();
      },
    );
  }
}












/*Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextFormField(
              controller: _fieldNameController,
              decoration: InputDecoration(labelText: 'Tarla Adı'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen tarla adını giriniz.';
                }
                return null;
              },
            ),
            // Diğer form alanları benzer şekilde oluşturulabilir.
            // Örneğin:
            TextFormField(
              controller: _fieldSizeController,
              decoration: InputDecoration(labelText: 'Tarla Alanı (Hektar)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen tarla alanını giriniz.';
                }
                return null;
              },
            ),
            // ... diğer alanlar
            ElevatedButton(
              onPressed: () {},
              child: Text('Kaydet'),
            ),
          ],
        ),
      ), */