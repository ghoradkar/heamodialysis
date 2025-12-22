import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heamodialysis/new_registration/model/viral_status/viral_data.dart';

class CustomRadialChart extends StatelessWidget {
  final List<ViralData> chartData;

  const CustomRadialChart({super.key, required this.chartData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 260, // Adjust the overall size
        height: 260,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Draw the tracks (background arcs)
            for (int i = 0; i < chartData.length; i++)
              CustomPaint(
                size: const Size(240, 240),
                painter: RadialTrackPainter(
                  index: i,
                  totalTracks: chartData.length,
                  color: Colors.grey.shade200,
                  strokeWidth: 15,
                ),
              ),
            // Draw the filled arcs (data)
            for (int i = 0; i < chartData.length; i++)
              CustomPaint(
                size: const Size(240, 240),
                painter: RadialBarPainter(
                  index: i,
                  totalTracks: chartData.length,
                  value: chartData[i].count?.toDouble() ?? 0.0,
                  color: chartData[i].dialColor!,
                  strokeWidth: 15,
                ),
              ),
            // Add the labels in the center
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: chartData.map((data) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      '${data.lookupDetDescEn}: ${data.count?.toInt()}',
                      style: TextStyle(color: data.dialColor, fontSize: 14),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Painter for the background tracks
class RadialTrackPainter extends CustomPainter {
  final int index;
  final int totalTracks;
  final Color color;
  final double strokeWidth;

  RadialTrackPainter({
    required this.index,
    required this.totalTracks,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final double radius = size.width / 2 - (index * strokeWidth * 1.5);
    const double startAngle = -pi / 2; // Start at the top
    const double sweepAngle = 3 * pi / 2; // 270 degrees

    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter for the filled radial bars
// Painter for the filled radial bars
class RadialBarPainter extends CustomPainter {
  final int index;
  final int totalTracks;
  final double value; // Percentage value (0–100)
  final Color color;
  final double strokeWidth;

  RadialBarPainter({
    required this.index,
    required this.totalTracks,
    required this.value,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2 - (index * strokeWidth * 1.5);
    const double startAngle = -pi / 2; // Start at the top
    final double normalizedValue =
        value.clamp(0.0, 100.0); // Clamp value to 0–100
    final double sweepAngle =
        (3 * pi / 2) * (normalizedValue / 100); // Scale within 270 degrees

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: radius,
      ),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// class RadialBarPainter extends CustomPainter {
//   final int index;
//   final int totalTracks;
//   final double value; // Percentage value (0–100)
//   final Color color;
//   final double strokeWidth;
//
//   RadialBarPainter({
//     required this.index,
//     required this.totalTracks,
//     required this.value,
//     required this.color,
//     required this.strokeWidth,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth
//       ..strokeCap = StrokeCap.round;
//
//     final double radius = size.width / 2 - (index * strokeWidth * 1.5);
//     const double startAngle = -pi / 2; // Start at the top
//     final double sweepAngle =
//         (3 * pi / 2) * (value / 100); // 270 degrees scaled by the value
//
//     canvas.drawArc(
//       Rect.fromCircle(
//           center: Offset(size.width / 2, size.height / 2), radius: radius),
//       startAngle,
//       sweepAngle,
//       false,
//       paint,
//     );
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }

// Data class for chart values
class RadialChartData {
  final String label;
  final double value; // Percentage value (0–100)
  final Color color;

  const RadialChartData(
      {required this.label, required this.value, required this.color});
}

// class RadialBarChartSample extends StatelessWidget {
//   final List<ViralData> chartData;
//
//   const RadialBarChartSample({super.key, required this.chartData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SfCircularChart(
//         title: const ChartTitle(
//             text: 'Viral Load Status', alignment: ChartAlignment.near),
//         legend: const Legend(isVisible: false),
//         series: <RadialBarSeries<ViralData, String>>[
//           RadialBarSeries<ViralData, String>(
//             dataSource: chartData,
//             xValueMapper: (ViralData data, _) => data.lookupDetDescEn,
//             yValueMapper: (ViralData data, _) => data.count,
//             pointColorMapper: (ViralData data, _) => data.dialColor,
//             cornerStyle: CornerStyle.bothCurve,
//             maximumValue: 100,
//             // Adjust based on your data
//             radius: '100%',
//             // Size of the circle
//             innerRadius: '40%',
//             // Adjust for a donut effect
//             dataLabelSettings: DataLabelSettings(
//               isVisible: true,
//               builder: (dynamic data, dynamic point, dynamic series,
//                   int pointIndex, int seriesIndex) {
//                 return Text(
//                   "${data.lookupDetDescEn} ${data.count.toString()}",
//                   style: TextStyle(color: data.dialColor),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
