import 'package:flutter/material.dart';

class LargeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const LargeCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 64, color: Colors.green),
              Text(title,
                  style: const TextStyle(fontSize: 16, color: Colors.green)),
              Text(subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.green)),
            ],
          ),
        ),
      ),
    );
  }
}
