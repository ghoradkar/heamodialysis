import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:heamodialysis/dashboard/model/bar_chart_model.dart';
import 'package:heamodialysis/widgets/custom_text.dart';

class BarChartSample extends StatelessWidget {
  final Color barColor;
  final List<BarChartModel> barChartModel;
  final String fromPage;

  const BarChartSample({
    super.key,
    required this.barColor,
    required this.barChartModel,
    required this.fromPage,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the minimum width of the chart
    final double screenWidth = MediaQuery.of(context).size.width;
    final double chartWidth = (barChartModel.isNotEmpty ? barChartModel.length * 80 : screenWidth);

    return Scaffold(
      body: barChartModel.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: chartWidth > screenWidth ? chartWidth : screenWidth, // Ensure width is at least screen width
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: getMaxY(),
                groupsSpace: 40,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        );
                        if (value.toInt() < barChartModel.length) {
                          String unitName =
                              barChartModel[value.toInt()].unitName ?? '';
                          // Limit to 10 characters and add ellipsis if necessary
                          String truncatedName = unitName.length > 10
                              ? '${unitName.substring(0, 10)}...'
                              : unitName;
                          return Text(
                            truncatedName, // Show only the first 10 characters
                            style: style,
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false), // Hide top labels
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false), // Hide right labels
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    left: BorderSide(color: Colors.black, width: 1),
                    bottom: BorderSide(color: Colors.black, width: 1),
                  ),
                ),
                barGroups: getBarGroups(),
                gridData: const FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  horizontalInterval: 10, // Adjust grid intervals
                ),
              ),
            ),
          ),
        ),
      )
          : const Align(
        alignment: Alignment.center,
        child: CustomText(
          text: "No Data",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textColor: Colors.black,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  List<BarChartGroupData> getBarGroups() {
    return List.generate(barChartModel.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: fromPage == "1"
                ? barChartModel[index].dischargeCount?.toDouble() ?? 0
                : barChartModel[index].abhaRegCount?.toDouble() ?? 0,
            color: barColor,
            width: 22,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(6),
              topLeft: Radius.circular(6),
            ),
          ),
        ],
      );
    });
  }

  double getMaxY() {
    double maxY = 0;
    for (var unit in barChartModel) {
      if (fromPage == "1") {
        if (unit.dischargeCount != null && unit.dischargeCount! > maxY) {
          maxY = unit.dischargeCount!.toDouble();
        }
      } else {
        if (unit.abhaRegCount != null && unit.abhaRegCount! > maxY) {
          maxY = unit.abhaRegCount!.toDouble();
        }
      }
    }
    return maxY + 10; // Adding 10 for padding
  }
}

// class BarChartSample extends StatelessWidget {
//   final Color barColor;
//   final List<BarChartModel> barChartModel;
//   final String fromPage;
//
//   const BarChartSample({
//     super.key,
//     required this.barColor,
//     required this.barChartModel,
//     required this.fromPage,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: barChartModel.isNotEmpty
//           ? Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: SizedBox(
//                   width: barChartModel.length * 80,
//                   child: BarChart(
//                     BarChartData(
//                       alignment: BarChartAlignment.spaceAround,
//                       maxY: getMaxY(),
//                       groupsSpace: 40,
//                       // Increase space between bars
//                       barTouchData: BarTouchData(enabled: false),
//                       titlesData: FlTitlesData(
//                         show: true,
//                         bottomTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             getTitlesWidget: (double value, TitleMeta meta) {
//                               const style = TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 12,
//                               );
//                               if (value.toInt() < barChartModel.length) {
//                                 String unitName =
//                                     barChartModel[value.toInt()].unitName ?? '';
//                                 // Limit to 10 characters and add ellipsis if necessary
//                                 String truncatedName = unitName.length > 10
//                                     ? '${unitName.substring(0, 10)}...'
//                                     : unitName;
//                                 return Text(
//                                   truncatedName, // Show only the first 10 characters
//                                   style: style,
//                                 );
//                               }
//                               return const Text('');
//                             },
//                           ),
//                         ),
//                         leftTitles: AxisTitles(
//                           sideTitles: SideTitles(
//                             showTitles: true,
//                             getTitlesWidget: (double value, TitleMeta meta) {
//                               return Text(
//                                 value.toInt().toString(),
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 12,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         topTitles: const AxisTitles(
//                           sideTitles:
//                               SideTitles(showTitles: false), // Hide top labels
//                         ),
//                         rightTitles: const AxisTitles(
//                           sideTitles: SideTitles(
//                               showTitles: false), // Hide right labels
//                         ),
//                       ),
//                       borderData: FlBorderData(show: false),
//                       barGroups: getBarGroups(),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           : const Align(
//               alignment: Alignment.center,
//               child: CustomText(
//                   text: "No Data",
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   textColor: Colors.black,
//                   textAlign: TextAlign.center),
//             ),
//     );
//   }
//
//   List<BarChartGroupData> getBarGroups() {
//     return List.generate(barChartModel.length, (index) {
//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(
//             toY: fromPage == "1"
//                 ? barChartModel[index].dischargeCount?.toDouble() ?? 0
//                 : barChartModel[index].abhaRegCount?.toDouble() ?? 0,
//             color: barColor,
//             width: 22,
//             borderRadius: const BorderRadius.only(
//               topRight: Radius.circular(6),
//               topLeft: Radius.circular(6),
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   double getMaxY() {
//     double maxY = 0;
//     for (var unit in barChartModel) {
//       if (fromPage == "1") {
//         if (unit.dischargeCount != null && unit.dischargeCount! > maxY) {
//           maxY = unit.dischargeCount!.toDouble();
//         }
//       } else {
//         if (unit.abhaRegCount != null && unit.abhaRegCount! > maxY) {
//           maxY = unit.abhaRegCount!.toDouble();
//         }
//       }
//     }
//     return maxY + 10; // Adding 10 for padding
//   }
// }
