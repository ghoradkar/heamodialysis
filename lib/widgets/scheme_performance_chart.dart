import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:heamodialysis/utils/color_constants.dart';
import 'package:heamodialysis/widgets/custom_text.dart';
import 'package:intl/intl.dart';

class SchemePerformanceChart extends StatelessWidget {
  final List<DateTime> dates;
  final List<int> mjpjayCounts;
  final List<int> nonMjpjayCounts;

  const SchemePerformanceChart({
    super.key,
    required this.dates,
    required this.mjpjayCounts,
    required this.nonMjpjayCounts,
  });

  @override
  Widget build(BuildContext context) {
    double? minYValue;
    double? maxYValue;
    double? yRange;
    double? interval;
    if (mjpjayCounts.isNotEmpty && nonMjpjayCounts.isNotEmpty) {
      minYValue =
          [mjpjayCounts.reduce(min), nonMjpjayCounts.reduce(min)].reduce(min) -
              1; // Adding padding
      maxYValue =
          [mjpjayCounts.reduce(max), nonMjpjayCounts.reduce(max)].reduce(max) +
              1; // Adding padding

      // Calculate the y-axis range and interval for better readability
      yRange = maxYValue - minYValue;
      interval = yRange <= 5 ? 0.5 : (yRange / 6).roundToDouble();
    }
    // Determine the min and max y values with some padding for display

    return mjpjayCounts.isNotEmpty && nonMjpjayCounts.isNotEmpty
        ? Column(
            children: [
              // Line Chart
              SizedBox(
                height: 360,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      horizontalInterval: interval,
                      verticalInterval: 1,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withValues(alpha: (0.3)),
                          strokeWidth: 1,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: Colors.grey.withValues(alpha: (0.3)),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 35,
                          interval: 1,
                          getTitlesWidget: bottomTitleWidgets,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: interval,
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
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: (dates.length - 1).toDouble(),
                    minY: minYValue,
                    maxY: maxYValue,
                    lineBarsData: [
                      // MJPJAY Line
                      LineChartBarData(
                        spots: List.generate(
                          dates.length,
                          (index) => FlSpot(
                              index.toDouble(), mjpjayCounts[index].toDouble()),
                        ),
                        isCurved: true,
                        color: AppColor.secondaryColor,
                        barWidth: 3,
                        dotData: const FlDotData(
                          show: true,
                        ),
                      ),
                      // Non-MJPJAY Line
                      LineChartBarData(
                        spots: List.generate(
                          dates.length,
                          (index) => FlSpot(index.toDouble(),
                              nonMjpjayCounts[index].toDouble()),
                        ),
                        isCurved: true,
                        color: AppColor.primaryBackgroundColor,
                        barWidth: 3,
                        dotData: const FlDotData(
                          show: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Indicator Row
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Indicator(
                    color: AppColor.secondaryColor,
                    text: "MJPJAY Counts",
                    isSquare: true,
                  ),
                  const SizedBox(width: 10),
                  Indicator(
                    color: AppColor.primaryBackgroundColor,
                    text: "Non-MJPJAY Counts",
                    isSquare: true,
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(vertical: 12, horizontal: 14)
        : const Center(
          child: CustomText(
              text: "No Data Found",
              fontSize: 16,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
              textAlign: TextAlign.center),
        );
  }

  // Widget to display bottom axis titles (dates)
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt();
    if (index < 0 || index >= dates.length) return Container();
    final DateFormat formatter = DateFormat('MM/yyyy');
    final String formattedDate = formatter.format(dates[index]);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(
        formattedDate,
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }

  // Widget to display left axis titles (y-axis values)
  Widget leftTitleWidgets(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4.0,
      child: Text(
        value.toStringAsFixed(1),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
  }
}

// Indicator Widget for legends
class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.isSquare = true,
    this.size = 14,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
              borderRadius: BorderRadius.circular(50)),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        )
      ],
    );
  }
}
