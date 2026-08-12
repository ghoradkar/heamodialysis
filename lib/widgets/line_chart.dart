import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartWidget extends StatelessWidget {
  final List<DateTime> dates;
  final List<double> preDialysisValue;
  final List<double> postDialysisValue;
  final String analysis;

  const LineChartWidget({
    super.key,
    required this.dates,
    required this.preDialysisValue,
    required this.postDialysisValue,
    required this.analysis,
  });

  @override
  Widget build(BuildContext context) {
    final int length = [
      dates.length,
      preDialysisValue.length,
      postDialysisValue.length,
    ].reduce((a, b) => a < b ? a : b);

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (length - 1).toDouble(),

        /// 🔒 FIXED Y-AXIS LIKE IMAGE
        minY: 0,
        maxY: 100,

        /// ---------------- GRID ----------------
        gridData: FlGridData(
          show: true,
          horizontalInterval: 25,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.withOpacity(0.3),
            strokeWidth: 1,
          ),
        ),

        /// ---------------- BORDER ----------------
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.grey.shade300),
        ),

        /// ---------------- AXIS TITLES ----------------
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            axisNameWidget: Text(
              analysis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            sideTitles: SideTitles(
              showTitles: true,
              interval: 25,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                );
              },
            ),
          ),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= dates.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('dd MMM yy').format(dates[index]),
                    style: const TextStyle(fontSize: 10),
                  ),
                );
              },
            ),
          ),

          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),

        /// ---------------- TOUCH (NO SCALE CHANGE) ----------------
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (touchedSpot) => Colors.black87,
            getTooltipItems: (spots) {
              return spots.map((spot) {
                return LineTooltipItem(
                  spot.y.toStringAsFixed(0),
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),

        /// ---------------- LINES ----------------
        lineBarsData: [
          /// 🔵 PRE-DIALYSIS (BLUE)
          LineChartBarData(
            spots: List.generate(
              length,
                  (i) => FlSpot(i.toDouble(), preDialysisValue[i]),
            ),
            isCurved: true,
            color: const Color(0xFF1E88E5),
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) =>
                  FlDotCirclePainter(
                    radius: 4,
                    color: const Color(0xFF1E88E5),
                  ),
            ),
          ),

          /// 🟢 POST-DIALYSIS (GREEN)
          LineChartBarData(
            spots: List.generate(
              length,
                  (i) => FlSpot(i.toDouble(), postDialysisValue[i]),
            ),
            isCurved: true,
            color: const Color(0xFF00C853),
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, bar, index) =>
                  FlDotCirclePainter(
                    radius: 4,
                    color: const Color(0xFF00C853),
                  ),
            ),
          ),
        ],

        /// ---------------- VALUE LABELS ON POINTS ----------------
        extraLinesData: ExtraLinesData(
          extraLinesOnTop: true,
          horizontalLines: [],
          verticalLines: [],
        ),
      ),

      /// ----------- VALUE BOXES LIKE IMAGE -----------
      // swapAnimationDuration: const Duration(milliseconds: 300),
    );
  }
}
