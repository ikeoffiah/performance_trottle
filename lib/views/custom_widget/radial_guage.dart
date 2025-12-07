import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/view_models/accel_view_model.dart';


class RadialGuage extends StatelessWidget {
  const RadialGuage({super.key});

  @override
  Widget build(BuildContext context) {
    final lastM = context.select<AccelViewModel, double>(
      (vm) => vm.mag.isNotEmpty ? vm.mag.last : 0.0,
    );
    final pct = (lastM.clamp(0.0, 20.0)) / 20.0;
    return  Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                const Text(
                  'Guage',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(value: pct, strokeWidth: 10),
                      Transform.rotate(
                        angle: (pct * pi * 1.4) - (pi * 0.7),
                        child: Container(
                          height: 6,
                          width: 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: Text(
                          lastM.toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
  }
}
