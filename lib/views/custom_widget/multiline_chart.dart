import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:test_1/view_models/accel_view_model.dart';

class MultilineChart extends StatelessWidget {
  const MultilineChart({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AccelViewModel>();
    final len = vm.mag.length;
    
    if (len == 0) {
      return const Center(
        child: Text('No data yet', style: TextStyle(color: Colors.grey)),
      );
    }

    final spotsX = List.generate(len, (i) => FlSpot(i.toDouble(), vm.x[i]));
    final spotsY = List.generate(len, (i) => FlSpot(i.toDouble(), vm.y[i]));
    final spotsZ = List.generate(len, (i) => FlSpot(i.toDouble(), vm.z[i]));
    final spotsM = List.generate(len, (i) => FlSpot(i.toDouble(), vm.mag[i]));

    return LineChart(
      LineChartData(
        gridData: const FlGridData(
          show: true,
          horizontalInterval: 2,
          verticalInterval: 20,
        ),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        minY: -20,
        maxY: 20,
        lineBarsData: <LineChartBarData>[
          LineChartBarData(
            spots: spotsX,
            isCurved: false,
            dotData: const FlDotData(show: false),
            barWidth: 2,
            color: Colors.red,
          ),
          LineChartBarData(
            spots: spotsY,
            isCurved: false,
            dotData: const FlDotData(show: false),
            barWidth: 2,
            color: Colors.green,
          ),
          LineChartBarData(
            spots: spotsZ,
            isCurved: false,
            dotData: const FlDotData(show: false),
            barWidth: 2,
            color: Colors.blue,
          ),
          LineChartBarData(
            spots: spotsM,
            isCurved: true,
            dotData: const FlDotData(show: false),
            barWidth: 3,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}