import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/view_models/accel_view_model.dart';
import 'package:test_1/views/custom_widget/value_column.dart';


class NumberCard extends StatelessWidget {
  const NumberCard({super.key});

  @override
  Widget build(BuildContext context) {
       final lastX = context.select<AccelViewModel, double>(
      (vm) => vm.x.isNotEmpty ? vm.x.last : 0.0,
    );
    final lastY = context.select<AccelViewModel, double>(
      (vm) => vm.y.isNotEmpty ? vm.y.last : 0.0,
    );
    final lastZ = context.select<AccelViewModel, double>(
      (vm) => vm.z.isNotEmpty ? vm.z.last : 0.0,
    );
    final lastM = context.select<AccelViewModel, double>(
      (vm) => vm.mag.isNotEmpty ? vm.mag.last : 0.0,
    );

    return Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Current readings', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Column(
                children: [
                  ValueColumn(label: 'X', value: lastX),
                  ValueColumn(label: 'Y', value: lastY),
                  ValueColumn(label: 'Z', value: lastZ),
                  ValueColumn(label: 'Mag', value: lastM),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: (lastM.clamp(0, 20)) / 20,
                minHeight: 6,
                backgroundColor: Colors.grey.shade200,
              ),
            ],
          ),
        ),
      );
  }
}