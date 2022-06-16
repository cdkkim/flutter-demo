import 'package:flutter_demo/bubble_loading/bubble_loading_initial_page.dart';
import 'package:flutter_demo/bubble_loading/cloud_paint.dart';
import 'package:flutter_demo/bubble_loading/dataBackupCompletedPainter.dart';
import 'package:flutter/material.dart';

const mainDataBackupColor = Color(0xFF5113AA);
const secondaryDataBackupColor = Color(0xFFBC53FA);
const backgroundColor = Color(0xFFfce7fe);

class BubbleLoadingApp extends StatefulWidget {
  const BubbleLoadingApp({Key? key}) : super(key: key);

  @override
  _BubbleLoadingAppState createState() => _BubbleLoadingAppState();
}

class _BubbleLoadingAppState extends State<BubbleLoadingApp> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> progressAnimation;
  late Animation<double> cloudOutAnimation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5));
    progressAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0, 0.65, curve: Curves.easeOut),
    );
    cloudOutAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0, 0.85, curve: Curves.easeOut),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          BubbleLoadingInitialPage(
            progressAnimation: progressAnimation,
            onAnimationStarted: () {
              animationController.forward();
            },
          ),
          Positioned(
            top: h * .15,
            left: w * .04,
            width: w,
            child: ClipOval(
              child: CustomPaint(
                painter: CloudPaint(progressAnimation, cloudOutAnimation),
                size: Size.fromHeight(h * .4),
              ),
            ),
          //   child: AnimatedBuilder(
          //     animation: Listenable.merge([
          //       progressAnimation,
          //       cloudOutAnimation,
          //     ]),
          //     builder: (context, snapshot) => CustomPaint(
          //       painter: CloudPaint(progressAnimation, cloudOutAnimation),
          //       size: Size.fromHeight(h * .4),
          //     ),
          //   ),
          ),
          Positioned(
            left: w * .5 - 40,
            // height: h * .5,
            bottom: 100,
            child: CustomPaint(
              painter: DataBackupCompletedPainter(progressAnimation),
              size: Size.fromRadius(40),
            ),
          )
        ],
      ),
    );
  }
}
