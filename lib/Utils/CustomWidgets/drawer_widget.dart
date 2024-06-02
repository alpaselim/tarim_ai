import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Data/models/user_model.dart';
import 'package:tarim_ai/Screens/HomeScreen/home.dart';
import 'package:tarim_ai/Screens/UserScreen/user_screen.dart';
import 'package:tarim_ai/Services/auth_service.dart';
import 'package:tarim_ai/Services/stream_service.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String name = "";
  String email = "";
  String profilePicture = '';

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
          profilePicture = user.profilePicture ?? '';
        });
      } else {
        //print('Belge mevcut değil');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    ImageProvider<Object> backgroundImage;

    if (profilePicture != '') {
      backgroundImage = NetworkImage(profilePicture);
    } else {
      backgroundImage = const AssetImage('assets/avatar_image.png');
    }
    return Material(
      color: kGreenColor,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const UserScreen(),
          ));
        },
        child: Container(
          color: kGreenColor,
          padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60, // Çemberin yarıçapı
                backgroundImage: backgroundImage,
                // Arkaplan resmi
              ),
              SizedBox(height: 12),
              Text(
                name,
                style: TextStyle(fontSize: 22, color: kWhiteColor),
              ),
              Text(
                email,
                style: TextStyle(fontSize: 16, color: kWhiteColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text("Home"),
            onTap: () {
              Get.offAll(() => const Home());
              /*  Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              ); */
            },
          ),
          /* const Divider(
            color: kBlackColor,
          ),  */
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text("Profil"),
            onTap: () {
              Get.to(() => const UserScreen());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Settings"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Exit"),
            onTap: () async {
              await authService.signOut(context);
            },
          ),
        ],
      ),
    );
  }
}
