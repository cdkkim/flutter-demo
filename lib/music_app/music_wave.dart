import 'dart:math';

import 'package:flutter_demo/music_app/music_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicWave extends StatefulWidget {
  final Size size;

  const MusicWave({Key? key, required this.size}) : super(key: key);

  @override
  _MusicWaveState createState() => _MusicWaveState();
}

class _MusicWaveState extends State<MusicWave> with SingleTickerProviderStateMixin {
  List<Offset> _points = [];
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: 2 * pi,
    );
    Random r = Random();
    for (int i = 0; i < widget.size.width; i++) {
      double x = i.toDouble();
      double y = r.nextDouble() * (widget.size.height * .8);
      _points.add(Offset(x, y));
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayStatus>(
      builder: (context, playStatus, child) {
        if (playStatus.isPlaying) {
          _controller.repeat();
        } else {
          _controller.stop();
        }

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipPath(
              clipper: WaveClipper(_controller.value, _points),
              child: const BlueGradient(),
            );
          },
        );
      },
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  double _value;
  List<Offset> _wavePoints;

  WaveClipper(this._value, this._wavePoints);

  @override
  Path getClip(Size size) {
    Path path = Path();
    // _makeSineWave(size);
    _modulateRandom(size);
    path.addPolygon(_wavePoints, false);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  void _makeSineWave(Size size) {
    final amplitude = size.height / 3;
    final yOffset = amplitude;
    for (int x = 0; x < size.width; x++) {
      double y = amplitude * sin(x / 4 - _value) + yOffset;
      Offset newPoint = Offset(x.toDouble(), y);
      _wavePoints[x] = newPoint;
    }
  }

  void _modulateRandom(Size size) {
    final maxDiff = 3.0;
    Random r = Random();
    for (int i = 0; i < size.width; i++) {
      var point = _wavePoints[i];
      double diff = maxDiff - r.nextDouble() * maxDiff * 2.0;

      double newY = max(0.0, point.dy + diff);
      newY = min(size.height, newY);

      Offset newPoint = Offset(point.dx, newY);
      _wavePoints[i] = newPoint;
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class BlueGradient extends StatelessWidget {
  final overlayHeight = 50.0;

  const BlueGradient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: overlayHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [
            Colors.blue,
            Colors.blue.withOpacity(0.4),
          ],
        ),
      ),
    );
  }
}
