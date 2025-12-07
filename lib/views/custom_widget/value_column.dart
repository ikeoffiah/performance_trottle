import 'package:flutter/material.dart';

class ValueColumn extends StatelessWidget {
  const ValueColumn({super.key, required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(value.toString(), style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}