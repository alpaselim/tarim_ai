import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Screens/HomeScreen/home.dart';
import 'package:tarim_ai/Screens/UserScreen/user_screen.dart';
import 'package:tarim_ai/Services/auth_service.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

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
          child: const Column(
            children: [
              CircleAvatar(
                radius: 52,
                backgroundImage: NetworkImage(
                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fdefault-profile-picture&psig=AOvVaw1RT387640gj_8nk7CSVCUa&ust=1714826080434000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCJCM7Yy_8YUDFQAAAAAdAAAAABAJ'),
              ),
              SizedBox(height: 12),
              Text(
                'Selim Alpa',
                style: TextStyle(fontSize: 22, color: kWhiteColor),
              ),
              Text(
                'selimalpa@gmail.com',
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
      padding: const EdgeInsets.all(24),
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
