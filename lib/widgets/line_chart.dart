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
    int minLength = [
      dates.length,
      preDialysisValue.length,
      postDialysisValue.length
    ].reduce((a, b) => a < b ? a : b);

    return Column(
      children: [
        // 🔹 Chart Title + Legends
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(width: 10, height: 10, color: Colors.red),
                const SizedBox(width: 5),
                Text('Pre-Dialysis $analysis',
                    style: const TextStyle(fontSize: 12, color: Colors.red)),
              ],
            ),
            const SizedBox(width: 20),
            Row(
              children: [
                Container(width: 10, height: 10, color: Colors.blue),
                const SizedBox(width: 5),
                Text('Post-Dialysis $analysis',
                    style: const TextStyle(fontSize: 12, color: Colors.blue)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),

        // 🔹 Chart with Axis Labels
        Expanded(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28, bottom: 28),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: 5,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      ),
                      getDrawingVerticalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.3),
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      // bottomTitles: AxisTitles(
                      //   axisNameWidget: const Padding(
                      //     padding: EdgeInsets.only(top: 10),
                      //     child: Text(
                      //       "Date",
                      //       style: TextStyle(
                      //         fontSize: 12,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //   ),
                      //   sideTitles: SideTitles(
                      //     showTitles: true,
                      //     reservedSize: 35,
                      //     interval: 1,
                      //     getTitlesWidget: bottomTitleWidgets,
                      //   ),
                      // ),
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
                          interval: 5,
                          reservedSize: 35,
                          getTitlesWidget: leftTitleWidgets,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey, width: 1),
                    ),
                    minX: 0,
                    maxX: (minLength - 1).toDouble(),
                    minY: [
                          preDialysisValue.reduce((a, b) => a < b ? a : b),
                          postDialysisValue.reduce((a, b) => a < b ? a : b),
                        ].reduce((a, b) => a < b ? a : b) -
                        5,
                    maxY: [
                          preDialysisValue.reduce((a, b) => a > b ? a : b),
                          postDialysisValue.reduce((a, b) => a > b ? a : b),
                        ].reduce((a, b) => a > b ? a : b) +
                        5,
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(
                          minLength,
                          (index) =>
                              FlSpot(index.toDouble(), preDialysisValue[index]),
                        ),
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                      ),
                      LineChartBarData(
                        spots: List.generate(
                          minLength,
                          (index) => FlSpot(
                              index.toDouble(), postDialysisValue[index]),
                        ),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),

              // // 🔹 Optional Axis Labels (outside chart)
              // const Positioned(
              //   left: 4,
              //   top: 0,
              //   bottom: 0,
              //   child: RotatedBox(
              //     quarterTurns: 3,
              //     child: Text(
              //       "Value",
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 12,
              //       ),
              //     ),
              //   ),
              // ),
              const Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= dates.length) return Container();
    final DateFormat formatter = DateFormat('MM/dd');
    final String formattedDate = formatter.format(dates[index]);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(
        formattedDate,
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(
        value.toStringAsFixed(0),
        style: const TextStyle(fontSize: 10),
      ),
    );
  }
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:heamodialysis/utils/color_constants.dart';
// import 'package:intl/intl.dart';
//
// class LineChartWidget extends StatelessWidget {
//   final List<DateTime> dates;
//   final List<double> preDialysisValue;
//   final List<double> postDialysisValue;
//   final String analysis;
//
//   const LineChartWidget({
//     super.key,
//     required this.dates,
//     required this.preDialysisValue,
//     required this.postDialysisValue,
//     required this.analysis,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     // Ensure the lists have the same length
//     int minLength = [
//       dates.length,
//       preDialysisValue.length,
//       postDialysisValue.length
//     ].reduce((a, b) => a < b ? a : b);
//
//     return Column(
//       children: [
//         // Chart Title and Legend
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Pre-Dialysis Indicator
//             Row(
//               children: [
//                 Container(
//                   width: 10,
//                   height: 10,
//                   color: Colors.red,
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   'Pre-Dialysis $analysis',
//                   style: const TextStyle(fontSize: 12, color: Colors.red),
//                 ),
//               ],
//             ),
//             const SizedBox(width: 20),
//             // Post-Dialysis Indicator
//             Row(
//               children: [
//                 Container(
//                   width: 10,
//                   height: 10,
//                   color: Colors.blue,
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   'Post-Dialysis $analysis',
//                   style: const TextStyle(fontSize: 12, color: Colors.blue),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(height: 10),
//         // Line Chart
//         Expanded(
//           child: LineChart(
//             LineChartData(
//               gridData: FlGridData(
//                 show: true,
//                 drawVerticalLine: true,
//                 horizontalInterval: 5,
//                 verticalInterval: 1,
//                 getDrawingHorizontalLine: (value) {
//                   return FlLine(
//                     color: Colors.grey.withValues(alpha: (0.3)),
//                     strokeWidth: 1,
//                   );
//                 },
//                 getDrawingVerticalLine: (value) {
//                   return FlLine(
//                     color: Colors.grey.withValues(alpha: (0.3)),
//                     strokeWidth: 1,
//                   );
//                 },
//               ),
//               titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     reservedSize: 35,
//                     interval: 1,
//                     getTitlesWidget: bottomTitleWidgets,
//                   ),
//                 ),
//                 leftTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 5,
//                     reservedSize: 35,
//                     getTitlesWidget: leftTitleWidgets,
//                   ),
//                 ),
//                 topTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//                 rightTitles: const AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//               ),
//               borderData: FlBorderData(
//                 show: true,
//                 border: Border.all(
//                   color: Colors.grey,
//                   width: 1,
//                 ),
//               ),
//               minX: 0,
//               maxX: (minLength - 1).toDouble(),
//               minY: [
//                     preDialysisValue.reduce((a, b) => a < b ? a : b),
//                     postDialysisValue.reduce((a, b) => a < b ? a : b),
//                   ].reduce((a, b) => a < b ? a : b) -
//                   5,
//               maxY: [
//                     preDialysisValue.reduce((a, b) => a > b ? a : b),
//                     postDialysisValue.reduce((a, b) => a > b ? a : b),
//                   ].reduce((a, b) => a > b ? a : b) +
//                   5,
//               lineBarsData: [
//                 // Pre-Dialysis Line
//                 LineChartBarData(
//                   spots: List.generate(
//                     minLength,
//                     (index) =>
//                         FlSpot(index.toDouble(), preDialysisValue[index]),
//                   ),
//                   isCurved: true,
//                   color: Colors.red,
//                   barWidth: 3,
//                   dotData: const FlDotData(
//                     show: true,
//                   ),
//                 ),
//                 // Post-Dialysis Line
//                 LineChartBarData(
//                   spots: List.generate(
//                     minLength,
//                     (index) =>
//                         FlSpot(index.toDouble(), postDialysisValue[index]),
//                   ),
//                   isCurved: true,
//                   color: Colors.blue,
//                   barWidth: 3,
//                   dotData: const FlDotData(
//                     show: true,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     final index = value.toInt();
//     if (index < 0 || index >= dates.length) return Container();
//     final DateFormat formatter = DateFormat('MM/dd');
//     final String formattedDate = formatter.format(dates[index]);
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4.0, // Add space to the titles
//       child: Text(
//         formattedDate,
//         style: const TextStyle(
//           fontSize: 10,
//         ),
//       ),
//     );
//   }
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 4.0,
//       child: Text(
//         value.toString(),
//         style: const TextStyle(
//           fontSize: 10,
//         ),
//       ),
//     );
//   }
// }
