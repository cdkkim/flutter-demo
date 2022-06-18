
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class SearchIconPainter extends CustomPainter {
  // 0..1
  final double progress;

  SearchIconPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    print(progress);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final circlePath = Path();

    circlePath.addArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: size.height,
        height: size.width,
      ),
      vector.radians(-90.0),
      vector.radians(360 * progress),
    );

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
