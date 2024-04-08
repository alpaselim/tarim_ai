import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const SmallCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double cardWidth = MediaQuery.of(context).size.width * 0.05;
    final double cardHeight = MediaQuery.of(context).size.height * 0.05;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: cardWidth,
          height: cardHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: cardHeight * 0.4, color: Colors.green),
              SizedBox(height: cardHeight * 0.1),
              Text(title, style: const TextStyle(color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
