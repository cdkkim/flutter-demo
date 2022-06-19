import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class SearchIconPainter extends CustomPainter {
  // 0..1
  final double progress;
  final int threshold;

  SearchIconPainter({required this.progress, required this.threshold});

  @override
  void paint(Canvas canvas, Size size) {
    double percent = progress < -threshold ? 1 : progress / -threshold;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;
    final circlePath = Path();

    circlePath.addArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, -40 - progress),
        width: 28,
        height: 28,
      ),
      vector.radians(-90.0),
      vector.radians(360 * percent),
    );

    if (progress < 0) {
      canvas.drawCircle(
        Offset(size.width / 2, -40 - progress),
        32,
        Paint()..color = percent >= 1 ? Colors.blue : Colors.white38,
      );
    }

    canvas.drawPath(circlePath, paint);

    if (percent >= 1) {
      canvas.drawLine(
        Offset(size.width / 2 + 8, 52 - 80 - progress),
        Offset(size.width / 2 + 8 + 8, 60 - 80 - progress),
        paint,
      );
    }

    // canvas.drawCircle(Offset.zero, 100, Paint());
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
