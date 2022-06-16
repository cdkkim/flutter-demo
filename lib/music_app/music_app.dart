import 'dart:math';

import 'package:flutter_demo/music_app/music_wave.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MusicApp extends StatefulWidget {
  const MusicApp({Key? key}) : super(key: key);

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  PlayStatus playStatus = PlayStatus();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music App"),
      ),
      body: ChangeNotifierProvider.value(
        value: playStatus,
        child: Consumer<PlayStatus>(
          builder: (context, status, child) => Column(
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: 'wildflower',
                    child: Image.asset('assets/music/wildflower.jpeg'),
                  ),
                  AnimatedOpacity(
                    opacity: status.isPlaying ? 1 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: MusicWave(size: MediaQuery.of(context).size),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (playStatus.isPlaying) {
                        _animationController.reverse();
                        playStatus.isPlaying = false;
                      } else {
                        _animationController.forward();
                        playStatus.isPlaying = true;
                      }
                    },
                    icon: AnimatedIcon(
                      progress: _animationController,
                      icon: AnimatedIcons.play_pause,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PlayStatus with ChangeNotifier {
  bool _isPlaying = false;

  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }
}
