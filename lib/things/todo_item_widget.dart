import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/things/things_app.dart';
import 'package:provider/provider.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem item;

  const TodoItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> with SingleTickerProviderStateMixin {
  bool expanded = false;
  Color transparent = Colors.transparent;
  late AnimationController animationController;
  bool longPressDown = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('tap');
        setState(() {
          expanded = !expanded;
        });
      },
      onTapDown: (TapDownDetails details) {
        print('tap down $details');
        setState(() {
          transparent = Colors.white24;
        });
      },
      onPanDown: (details) {
        _timer = Timer(const Duration(seconds: 1), () {
          HapticFeedback.lightImpact();
          setState(() {
            transparent = Colors.blueAccent;
            longPressDown = true;
          });
        });
      },
      onPanCancel: () => _timer?.cancel(),
      onTapCancel: () {
        print('tap cancel');
        setState(() {
          transparent = Colors.transparent;
          longPressDown = false;
        });
      },
      onTapUp: (details) {
        print('tap up');
        setState(() {
          transparent = Colors.transparent;
          longPressDown = false;
        });
      },
      child: Transform.scale(
        scale: longPressDown ? 1.08 : 1,
        child: AnimatedContainer(
          margin: EdgeInsets.symmetric(horizontal: expanded ? 0 : 4),
          height: expanded ? 160 : 48,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: EdgeInsets.symmetric(horizontal: expanded ? 8 : 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: expanded ? Colors.white12 : transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_box_outline_blank_rounded, color: Colors.white38),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.item.title, style: TextStyle(fontSize: 20)),
                  // if (expanded) Text('Notes'),
                  // if (expanded) Text('o todo item'),
                  // if (expanded)
                  //   Row(
                  //     children: const [
                  //       Icon(Icons.star_rounded),
                  //       Text('Today'),
                  //       Spacer(),
                  //       Icon(Icons.bookmark_border_outlined),
                  //       Icon(Icons.flag_outlined),
                  //     ],
                  //   )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
