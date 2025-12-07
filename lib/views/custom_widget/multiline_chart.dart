import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:test_1/view_models/accel_view_model.dart';

class MultilineChart extends StatelessWidget {
  const MultilineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<AccelViewModel, double?>(
      selector: (_, vm) => vm.mag.isEmpty ? null : vm.mag.last,
      builder: (context, latestMag, __) {
        final vm = context.read<AccelViewModel>();
        final len = vm.mag.length;
        final spotsX = List.generate(len, (i) => FlSpot(i.toDouble(), vm.x[i]));
        final spotsY = List.generate(len, (i) => FlSpot(i.toDouble(), vm.y[i]));
        final spotsZ = List.generate(len, (i) => FlSpot(i.toDouble(), vm.z[i]));
        final spotsM = List.generate(len, (i) => FlSpot(i.toDouble(), vm.mag[i]));

        return LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              horizontalInterval: 2,
              verticalInterval: 20,
            ),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minY: -20,
            maxY: 20,
            lineBarsData: <LineChartBarData>[
              LineChartBarData(
                spots: spotsX,
                isCurved: false,
                dotData: FlDotData(show: false),
                barWidth: 2,
                color: Colors.red,
              ),
              LineChartBarData(
                spots: spotsY,
                isCurved: false,
                dotData: FlDotData(show: false),
                barWidth: 2,
                color: Colors.green,
              ),
              LineChartBarData(
                spots: spotsZ,
                isCurved: false,
                dotData: FlDotData(show: false),
                barWidth: 2,
                color: Colors.blue,
              ),
              LineChartBarData(
                spots: spotsM,
                isCurved: true,
                dotData: FlDotData(show: false),
                barWidth: 3,
                color: Colors.purple,
              ),
            ],
          ),
        );
      },
    );
  }
}
