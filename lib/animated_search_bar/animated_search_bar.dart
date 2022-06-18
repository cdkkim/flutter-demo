import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://www.youtube.com/watch?v=etPTwkpOlRk
class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({Key? key}) : super(key: key);

  @override
  _AnimatedSearchBarState createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> with SingleTickerProviderStateMixin {
  int _toggle = 1;
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: const Color(0xfff2f3f7),
        child: Center(
          child: Container(
            height: 100,
            width: 250,
            alignment: Alignment(-1, 0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              height: 48,
              width: (_toggle == 0) ? 48 : 250,
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: -10,
                    blurRadius: 10.0,
                    offset: Offset(0, 10),
                  )
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    // duration: Duration(milliseconds: 400),
                    top: 6,
                    right: 7,
                    // curve: Curves.easeOut,
                    child: AnimatedOpacity(
                      opacity: _toggle == 0 ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f3f7),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: AnimatedBuilder(
                          child: Icon(Icons.mic, size: 20),
                          builder: (context, widget) {
                            return Transform.rotate(
                              angle: _controller.value * 2 * pi,
                              child: widget,
                            );
                          },
                          animation: _controller,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 400),
                    left: _toggle == 0 ? 20 : 40,
                    top: 13,
                    curve: Curves.easeOut,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: _toggle == 0 ? 0 : 1,
                      child: Container(
                        height: 23,
                        width: 180,
                        child: TextField(
                          cursorRadius: Radius.circular(10),
                          cursorWidth: 2,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                              labelText: 'Search...',
                              labelStyle: TextStyle(
                                color: Color(0xff5b5b5b),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          if (_toggle == 0) {
                            _toggle = 1;
                            _controller.forward();
                          } else {
                            _toggle = 0;
                            _controller.reverse();
                          }
                        });
                      },
                      icon: Icon(Icons.search),
                      // icon: Image.network(
                      //   'https://www.flaticon.com/svg/static/icons/svg/709/709592.svg',
                      //   height: 18,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
