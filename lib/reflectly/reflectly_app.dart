import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/reflectly/account_login.dart';
import 'package:flutter_demo/reflectly/reflectly_landing_page.dart';
import 'package:flutter_demo/reflectly/shared_axis_page_route.dart';

class ReflectlyApp extends StatefulWidget {
  const ReflectlyApp({Key? key}) : super(key: key);

  @override
  _ReflectlyAppState createState() => _ReflectlyAppState();
}

class _ReflectlyAppState extends State<ReflectlyApp> {
  PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflectly'),
      ),
      backgroundColor: Colors.indigoAccent[100],
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          ReflectlyLandingPage(onTap: () {
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          }),
          Container(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    left: 0,
                    child: IconButton(
                      onPressed: () {
                        pageController.animateToPage(
                          0,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.indigo[100],
                      ),
                    ),
                  ),
                  Positioned(
                    top: h * .05,
                    child: const Text(
                      'So nice to mee you! What do\nyour friend call you?',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Positioned(
                    top: h * .3,
                    child: Container(
                      width: w,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Your nickname...',
                            hintStyle: TextStyle(color: Colors.white)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: h * .1,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Continue"),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
