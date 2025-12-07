import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/view_models/accel_view_model.dart';
import 'package:test_1/views/custom_widget/legend.dart';
import 'package:test_1/views/custom_widget/number_card.dart';
import 'package:test_1/views/custom_widget/radial_guage.dart';
import 'package:test_1/views/custom_widget/multiline_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final running = context.select<AccelViewModel, bool>((vm) => vm.running);

    return Scaffold(
      appBar: AppBar(title: const Text('Accelerometer Live')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: NumberCard()),
                  const SizedBox(width: 12),
                  Expanded(child: RadialGuage()),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text(
                          'Live graph (last readings)',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),

                        const SizedBox(height: 12),
                        Expanded(child: MultilineChart()),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(children: [const Legend(), const Spacer()]),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Text(
                    'Tip: move device to see changes',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Spacer(),
                ],
              ),

              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.small(
                    heroTag: 'toggle',
                    onPressed: () => context.read<AccelViewModel>().toggle(),
                    tooltip: running ? 'Stop' : 'Start',
                    child: Icon(running ? Icons.pause : Icons.play_arrow),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.small(
                    heroTag: 'refresh',
                    onPressed: () => context.read<AccelViewModel>().clear(),
                    tooltip: 'Clear history',
                    child: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
