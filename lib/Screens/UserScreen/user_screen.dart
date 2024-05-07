import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';
import 'package:tarim_ai/Utils/CustomWidgets/custom_buttom_app_bar.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final CustomButtomAppBar customButtomAppBar = const CustomButtomAppBar();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRedColor,
      appBar: AppBar(
        title: const Text('Title'),
      ),
    );
  }
}
