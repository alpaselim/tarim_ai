import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Services/firestore_service.dart';
import 'package:tarim_ai/Services/snackbar_service.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? currentUserProfilePicture;

  // final currentUser = FirebaseAuth.instance.currentUser;
  String? currentUserEmail;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    //initializeCurrentUserEmail();
    // StreamService'den kullanıcıları dinleyin
    streamService
        .getCurrentUser()
        .listen((DocumentSnapshot<UserModel> snapshot) {
      if (snapshot.exists) {
        // Belge mevcut olduğunda kullanıcı bilgilerini alın
        UserModel user = snapshot.data()!;
        // Kullanıcı bilgilerini al ve ilgili TextEditingController'ların içine yerleştir
        nameController.text = user.name ?? '';
        emailController.text = user.email ?? '';
        phoneNumberController.text = user.phoneNumber ?? '';
        currentUserProfilePicture = user.profilePicture ?? '';
      } else {
        // Belge mevcut değilse buraya düşebilirsiniz
        //  print('Belge mevcut değil');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  //width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/EditVector.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.5 - 60,
                  top: 140,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: // Seçilen resmi göster
                        currentUserProfilePicture != null
                            ? NetworkImage(currentUserProfilePicture!)
                            : const NetworkImage(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8AJM9wkP__z2M-hovSAWcTb_9XJ6smy3NKw&s'),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  child: const Text(
                    "Edit Profile",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  right: MediaQuery.of(context).size.width * 0.5 -
                      50, // Yatayda ortalanmış pozisyon
                  top: 225,
                  child: InkWell(
                    child: Image.asset(
                      'assets/photoEdit.png',
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Fotoğraf Seçin'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: const ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text('Galeriden Seç'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                    },
                                    child: const ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Kamerayı Kullan'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  userCard("Name", nameController),
                  const SizedBox(height: 20),
                  userCard("E-Mail", emailController),
                  const SizedBox(height: 20),
                  userCard("Phone no", phoneNumberController),
                  const SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kRedColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                        child: Text(
                      "Delete Account",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                          child: Text(
                        "Save Changes",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )),
                    ),
                    onTap: () {
                      saveUserInfo();
                      Get.back();
                      snackbarService
                          .showSuccessSnackBar('Changes saved successfully');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userCard(String header, TextEditingController controller) {
    bool isEmailHeader = header == 'E-Mail';
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 80,
              decoration: BoxDecoration(
                color: kCustomGreyColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: controller,
                enabled: !isEmailHeader,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  // hintText: header,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> saveUserInfo() async {
    String newName = nameController.text;
    String newPhoneNumber = phoneNumberController.text;
    String imageUrl = await fireStoreService.uploadImage(_selectedImage!);
    fireStoreService.editUserProfile(newName, newPhoneNumber, imageUrl);
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }
}
