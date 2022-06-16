import 'dart:math';

import 'package:flutter_demo/bubble_loading/bubble_loading_app.dart';
import 'package:flutter/material.dart';

class CloudPaint extends CustomPainter {
  Animation<double> progressAnimation;
  Animation<double> cloudOutAnimation;
  final bubbles = List<Bubble>.generate(200, (index) {
    final size = Random().nextInt(20) + 5.0;
    final speed = Random().nextInt(50) + 1.0;
    final directionRandom = Random().nextBool();
    final colorRandom = Random().nextBool();
    final direction = Random().nextInt(250) * (directionRandom ? 1.0 : -1.0);
    final color = colorRandom ? mainDataBackupColor : secondaryDataBackupColor;
    return Bubble(
      size: size,
      speed: speed,
      direction: direction,
      color: color,
      initialPosition: index * 10,
    );
  });

  CloudPaint(this.progressAnimation, this.cloudOutAnimation);

  @override
  void paint(Canvas canvas, Size size) {
    // left circle
    canvas.drawCircle(
      Offset(size.height / 4 + cloudOutAnimation.value * 100, size.height / 2),
      size.height / 4,
      Paint()..color = Colors.white,
    );
    // right circle
    canvas.drawCircle(
      Offset(size.height / 1.2 - cloudOutAnimation.value * 100, size.height / 2),
      size.height / 4,
      Paint()..color = Colors.white,
    );
    // center
    canvas.drawCircle(
      Offset(size.height / 1.8,
          size.height / 2.5 - (progressAnimation.value + cloudOutAnimation.value) * 100),
      size.height / 3 * (progressAnimation.value + cloudOutAnimation.value + 1),
      Paint()..color = Colors.white,
    );
    // cloud bottom
    canvas.drawLine(
      Offset(80, size.height / 1.45),
      Offset(size.width / 1.4, size.height / 1.45),
      Paint()
        ..strokeWidth = 40 * pow((1 - progressAnimation.value), 10).toDouble()
        ..color = Colors.white,
    );

    for (Bubble bubble in bubbles) {
      final offset = Offset(
        size.width / 2 + bubble.direction * progressAnimation.value,
        size.height * (1 - progressAnimation.value) -
            bubble.speed * progressAnimation.value +
            bubble.initialPosition * (1 - progressAnimation.value),
      );
      canvas.drawCircle(offset, bubble.size, Paint()..color = bubble.color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Bubble {
  final Color color;
  final double direction;
  final double speed;
  final double size;
  final double initialPosition;

  Bubble({
    required this.color,
    required this.direction,
    required this.speed,
    required this.size,
    required this.initialPosition,
  });
}
