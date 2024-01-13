import 'package:flutter/material.dart';
import 'package:tarim_ai/Data/app_constants.dart';

class CustomWelcomeButton extends StatelessWidget {
  const CustomWelcomeButton({
    super.key,
    this.color = kWelcomeGreyColor,
    this.onPressed,
    required this.text,
  });

  final Color color;
  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Saydamlık eklemek için renk ve opaklık değeri
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: kWhiteColor,
        ),
      ),
    );
  }
}
