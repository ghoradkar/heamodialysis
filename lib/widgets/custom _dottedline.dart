import 'package:flutter/material.dart';

// ==================== VERTICAL DOTTED DIVIDER ====================
class VerticalDottedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashHeight;
  final Color color;

  const VerticalDottedDivider({
    super.key,
    required this.height,
    this.dashWidth = 1,
    this.dashHeight = 4,
    this.color = const Color(0xFF555555),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(dashWidth, height),
      painter: _VerticalDottedLinePainter(
        dashHeight: dashHeight,
        dashWidth: dashWidth,
        color: color,
      ),
    );
  }
}

class _VerticalDottedLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashWidth;
  final Color color;

  _VerticalDottedLinePainter({
    required this.dashHeight,
    required this.dashWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashWidth;

    while (startY < size.height) {
      canvas.drawLine(
        Offset(0, startY),
        Offset(0, startY + dashHeight),
        paint,
      );
      startY += 2 * dashHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==================== HORIZONTAL DOTTED DIVIDER ====================
class HorizontalDottedDivider extends StatelessWidget {
  final double width;
  final double dashWidth;
  final double dashHeight;
  final Color color;

  HorizontalDottedDivider({
    Key? key,
    required this.width,
    this.dashWidth = 1,
    this.dashHeight = 4,
    this.color = const Color(0xFF555555),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, dashWidth),
      painter: _HorizontalDottedLinePainter(
        dashHeight: dashHeight,
        dashWidth: dashWidth,
        color: color,
      ),
    );
  }
}

class _HorizontalDottedLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashWidth;
  final Color color;

  _HorizontalDottedLinePainter({
    required this.dashHeight,
    required this.dashWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double startX = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = dashWidth;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashHeight, 0),
        paint,
      );
      startX += 2 * dashHeight;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}