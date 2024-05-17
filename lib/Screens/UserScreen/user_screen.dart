import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Screens/UserScreen/edit_profile.dart';
import 'package:tarim_ai/Services/stream_service.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_buttom_app_bar.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final CustomButtomAppBar customButtomAppBar = const CustomButtomAppBar();
  String? name;
  String? email;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    streamService
        .getCurrentUser()
        .listen((DocumentSnapshot<UserModel> snapshot) {
      if (snapshot.exists) {
        UserModel user = snapshot.data()!;
        setState(() {
          name = user.name ?? '';
          email = user.email ?? '';
          phoneNumber = user.phoneNumber ?? '';
        });
      } else {
        //print('Belge mevcut değil');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                //width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Vector.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                //top: MediaQuery.of(context).size.height * 0.2,
                left: MediaQuery.of(context).size.width * 0.5 -
                    60, // Yatayda ortalanmış pozisyon
                bottom: 0,
                child: const CircleAvatar(
                  radius: 60, // Çemberin yarıçapı
                  backgroundImage:
                      AssetImage('assets/avatar_image.png'), // Arkaplan resmi
                  //backgroundImage: NetworkImage('url'), // İnternetten resim
                  //backgroundColor: Colors.blue, // Arkaplan rengi
                  //child: Icon(Icons.person), // İkon kullanımı
                ),
              ),
              Positioned(
                top: 30,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: const Text(
                  "Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                child: InkWell(
                  onTap: () {
                    Get.to(() => const EditProfile());
                  },
                  child: Image.asset(
                    'assets/Edit.png',
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 30),
            child: Column(
              children: [
                const SizedBox(height: 20),
                userCard("assets/Name.png", "Name", name ?? ''),
                const SizedBox(height: 20),
                userCard("assets/Email.png", "E-mail", email ?? ''),
                const SizedBox(height: 20),
                userCard("assets/Phone.png", "Phone no", phoneNumber ?? ''),
                const SizedBox(height: 20),
                userCard("assets/Department.png", "Department", "Selim Alpa"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row userCard(String iconPath, String header, String content) {
    return Row(
      children: [
        Image.asset(
          iconPath,
        ),
        const SizedBox(width: 40),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}

/*  return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Vector.png'),
              fit: BoxFit.scaleDown,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(width: 30),
                  InkWell(
                    onTap: () {
                      Navigator.canPop(context) ? Navigator.pop(context) : null;
                    },
                    child: Navigator.canPop(context)
                        ? Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: kBlackColor,
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
              // Expanded(child: body),
            ],
          ),
        ),
      ),
    ); */
