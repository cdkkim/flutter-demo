import 'package:flutter_demo/bubble_loading/bubble_loading_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class DataBackupCompletedPainter extends CustomPainter {

  final Animation<double> animation;

  DataBackupCompletedPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = mainDataBackupColor
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
      vector.radians(360 * animation.value),
    );

    final leftLine = size.width * .2;
    final rightLine = size.width * .4;

    final leftPercent = animation.value > .5 ? 1 : animation.value / .5;
    final rightPercent = animation.value < .5 ? 0.0 : (animation.value - .5) / .5;

    canvas.save();
    
    canvas.translate(size.width / 3, size.height / 2);
    canvas.rotate(vector.radians(-45));

    // v mark
    canvas.drawLine(Offset.zero, Offset(0, leftLine * leftPercent), paint);
    canvas.drawLine(Offset(0, leftLine), Offset(rightLine * rightPercent, leftLine), paint);
    
    canvas.restore();

    canvas.drawPath(circlePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
