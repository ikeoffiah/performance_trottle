import 'package:flutter/material.dart';
import 'package:test_1/views/custom_widget/legend_item.dart';

class Legend extends StatelessWidget {
  const Legend({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LegendItem(color: Colors.red, label: 'X'),
        const SizedBox(width: 8),
        LegendItem(color: Colors.green, label: 'Y'),
        const SizedBox(width: 8),
        LegendItem(color: Colors.blue, label: 'Z'),
        const SizedBox(width: 8),
        LegendItem(color: Colors.purple, label: 'Mag'),
      ],
    );
  }
}