import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Screens/LoginScreen/login_screen.dart';
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
  String profilePicture = '';

  String? currentUserEmail;
  File? _selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    streamService
        .getCurrentUser()
        .listen((DocumentSnapshot<UserModel> snapshot) {
      if (snapshot.exists) {
        UserModel user = snapshot.data()!;
        setState(() {
          profilePicture = user.profilePicture ?? '';
        });
        nameController.text = user.name ?? '';
        emailController.text = user.email ?? '';
        phoneNumberController.text = user.phoneNumber ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> backgroundImage;

    if (profilePicture != '') {
      backgroundImage = NetworkImage(profilePicture);
    } else {
      backgroundImage = const AssetImage('assets/avatar_image.png');
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.30,
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
                        backgroundImage: backgroundImage,
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: MediaQuery.of(context).size.width / 2 - 50,
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      right: MediaQuery.of(context).size.width * 0.5 - 50,
                      top: 225,
                      child: InkWell(
                        child: Image.asset('assets/photoEdit.png'),
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
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: kRedColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Delete Account",
                              style:
                                  TextStyle(fontSize: 20, color: kWhiteColor),
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Delete your Account?'),
                                content: const Text(
                                  "Are you sure you want to delete your account? This action is irreversible and all your data will be permanently deleted.",
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('Cancel'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Delete'),
                                    onPressed: () async {
                                      await fireStoreService
                                          .deleteUserAccount();
                                      Get.offAll(() => const LoginScreen());
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 80,
                          height: 50,
                          decoration: BoxDecoration(
                            color: kGreenColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Save Changes",
                              style:
                                  TextStyle(fontSize: 20, color: kWhiteColor),
                            ),
                          ),
                        ),
                        onTap: isLoading
                            ? null
                            : () async {
                                setState(() {
                                  isLoading = true;
                                });

                                try {
                                  await saveUserInfo();
                                  Get.back();
                                  snackbarService.showSuccessSnackBar(
                                      'Changes saved successfully');
                                } catch (e) {
                                  snackbarService.showErrorSnackBar(
                                      'Failed to save changes: $e');
                                } finally {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
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
            const SizedBox(height: 5),
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
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Future<void> saveUserInfo() async {
    try {
      String newName = nameController.text;
      String newPhoneNumber = phoneNumberController.text;
      String imageUrl = _selectedImage != null
          ? await fireStoreService.uploadImage(_selectedImage!)
          : profilePicture;

      await fireStoreService.editUserProfile(newName, newPhoneNumber, imageUrl);
    } catch (e) {
      throw Exception('Error saving user info: $e');
    }
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
