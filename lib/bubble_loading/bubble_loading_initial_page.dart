import 'package:flutter_demo/bubble_loading/bubble_loading_app.dart';
import 'package:flutter/material.dart';

enum DataBackupState { initial, start, end }

class BubbleLoadingInitialPage extends StatefulWidget {
  final VoidCallback onAnimationStarted;
  final Animation<double> progressAnimation;

  const BubbleLoadingInitialPage({
    Key? key,
    required this.onAnimationStarted,
    required this.progressAnimation,
  }) : super(key: key);

  @override
  _BubbleLoadingInitialPageState createState() => _BubbleLoadingInitialPageState();
}

class _BubbleLoadingInitialPageState extends State<BubbleLoadingInitialPage> {
  DataBackupState _currentState = DataBackupState.initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              flex: 3,
              child: Text(
                'Cloud Storage',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            if (_currentState == DataBackupState.end)
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      'Uploading files',
                      style: TextStyle(),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          // child: Text('6%'),
                          child: ProgressCounter(listenable: widget.progressAnimation),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (_currentState != DataBackupState.end)
              Expanded(
                flex: 2,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 300),
                  tween: Tween<double>(
                    begin: 1,
                    end: _currentState == DataBackupState.initial ? 1 : 0,
                  ),
                  onEnd: () {
                    setState(() {
                      _currentState = DataBackupState.end;
                    });
                  },
                  builder: (context, double value, child) {
                    return Transform.translate(
                      offset: Offset(0, -40 * value),
                      child: Opacity(opacity: value, child: child),
                    );
                  },
                  child: Column(
                    children: const [
                      Text('Last backup'),
                      Text('28 May 2021'),
                    ],
                  ),
                ),
              ),
            if (_currentState == DataBackupState.initial)
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(mainDataBackupColor),
                ),
                onPressed: () {
                  setState(() {
                    _currentState = DataBackupState.start;
                  });
                  widget.onAnimationStarted();
                },
                child: const Text(
                  'Create Backup',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (_currentState == DataBackupState.start)
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentState = DataBackupState.initial;
                    });
                  },
                  child: const Text('Cancel', style: TextStyle(color: mainDataBackupColor))),
          ],
        ),
      ),
    );
  }
}

class ProgressCounter extends AnimatedWidget {
  ProgressCounter({required super.listenable});

  double get value => (listenable as Animation).value;

  @override
  Widget build(BuildContext context) {
    return Text('${(value * 100).truncate().toString()}%');
  }
}
