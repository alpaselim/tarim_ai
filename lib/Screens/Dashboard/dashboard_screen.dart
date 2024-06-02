import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.30,
        //width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/dashboard.png'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
