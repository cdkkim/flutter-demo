import 'package:flutter/material.dart';
import 'package:flutter_demo/reflectly/shared_axis_page_route.dart';

import 'account_login.dart';

class ReflectlyLandingPage extends StatefulWidget {
  Function onTap;

  ReflectlyLandingPage({Key? key, required this.onTap}) : super(key: key);

  @override
  _ReflectlyLandingPageState createState() => _ReflectlyLandingPageState();
}

class _ReflectlyLandingPageState extends State<ReflectlyLandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    super.initState();
  }

  Widget slideUpWithOpacity(Widget child) {
    return Opacity(
      opacity: _animationController.value,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, -10),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeIn,
        )),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: h * .1),
          Opacity(
            opacity: _animationController.value,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -10),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeIn,
              )),
              child: const Text(
                'Hi there,\nI\'m Reflectly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: h * .04),
          slideUpWithOpacity(Text(
            'Your new personal\nself-care companion',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.indigo[50],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
          const Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 20),
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            onPressed: () {
              widget.onTap();
            },
            child: const Text(
              "HI, REFLECTLY!",
              style: TextStyle(
                color: Colors.indigoAccent,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: h * .04),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(SharedAxisPageRoute(
                page: const AccountLogin(),
              ));
            },
            child: const Text(
              'I already have an account',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          SizedBox(height: h * .1),
        ],
      ),
    );
  }
}
