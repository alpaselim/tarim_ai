import 'package:flutter/material.dart';

class ResponsiveGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Ekran boyutunu al
    var screenSize = MediaQuery.of(context).size;

    // Ekran genişliğine göre sütun sayısını belirle
    int crossAxisCount = screenSize.width > 600 ? 3 : 2;

    // Her bir card'ın boy/en oranını belirle
    double childAspectRatio = screenSize.width / (screenSize.height / 2);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) {
        return Card(
          child: Center(child: Text('Card $index')),
        );
      },
      itemCount: 6,
    );
  }
}
