import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPress; // Parametre olarak bir fonksiyon tanımlayın

  const CustomTextButton({
    super.key,
    required this.onPress, // Kurucuda parametre olarak alın
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(kGreenColor),
        minimumSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(10)),
      ),
      child: const Text(
        'SUBMIT',
        style: TextStyle(fontSize: 18, color: kWhiteColor),
      ),
    );
  }
}
