import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MessageAnimationApp extends StatefulWidget {
  const MessageAnimationApp({Key? key}) : super(key: key);

  @override
  _MessageAnimationAppState createState() => _MessageAnimationAppState();
}

class _MessageAnimationAppState extends State<MessageAnimationApp> {
  final minSize = 50.0;
  final maxSize = 150.0;
  final iconSize = 24.0;
  bool expanded = false;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration:
                      BoxDecoration(color: Colors.black38, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      const SizedBox(width: 8),
                      Text('Search conversations'),
                      Spacer(),
                      Icon(Icons.more_vert_outlined)
                    ],
                  )),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (details) {
                    // if (details.metrics.pixels < 10) {
                    //   setState(() {
                    //     expanded = false;
                    //   });
                    //   return true;
                    // }
                    setState(() {
                      if (controller.position.userScrollDirection == ScrollDirection.forward &&
                          !expanded) {
                        expanded = true;
                      } else if (controller.position.userScrollDirection ==
                              ScrollDirection.reverse &&
                          expanded) {
                        expanded = false;
                      }
                    });
                    return true;
                  },
                  child: ListView.builder(
                    controller: controller,
                    itemCount: 25,
                    itemBuilder: (context, idx) {
                      return ListTile(
                          title: Text('Title'),
                          subtitle: Text("Hello world, welcome to flutter"),
                          trailing: Text('20 min'),
                          leading: CircleAvatar(
                            backgroundColor: Colors.primaries[idx % Colors.primaries.length],
                            child: Icon(Icons.person, color: Colors.black87),
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: AnimatedContainer(
          width: expanded ? maxSize : minSize,
          height: minSize,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(minSize),
          ),
          duration: const Duration(milliseconds: 200),
          child: Stack(
            children: [
              Positioned(
                left: minSize / 2 - iconSize / 2,
                top: minSize / 2 - iconSize / 2,
                child: Icon(Icons.message, size: iconSize),
              ),
              if (expanded)
                Positioned(
                  top: minSize / 2 - iconSize / 2 + 2,
                  left: minSize / 2 - iconSize / 2 + iconSize + 8,
                  child: Text('Start chat'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
