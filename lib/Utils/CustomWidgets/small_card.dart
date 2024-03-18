import 'package:flutter/material.dart';

// Küçük Kart
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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.green),
            Text(title, style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
