import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/things/search_icon_painter.dart';
import 'package:provider/provider.dart';

import 'todo_item_widget.dart';

class ThingsApp extends StatefulWidget {
  const ThingsApp({Key? key}) : super(key: key);

  @override
  _ThingsAppState createState() => _ThingsAppState();
}

class _ThingsAppState extends State<ThingsApp> with SingleTickerProviderStateMixin {
  List<TodoItem> todos = [];
  ScrollController scrollController = ScrollController();
  late AnimationController animationController;
  bool showHighlight = true;
  bool displaySearchWidget = false;
  bool vibrated = false;

  @override
  void initState() {
    super.initState();
    List.generate(20, (index) {
      todos.add(TodoItem('$index'));
    });
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: Transform.rotate(
                angle: pi / 2 * 3,
                child: const Icon(Icons.arrow_back_ios_rounded),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: scrollController,
              builder: (context, child) {
                if (scrollController.positions.isEmpty) {
                  return Container();
                }
                int threshold = 80;
                if (scrollController.offset <= -threshold) {
                  if (!vibrated) {
                    HapticFeedback.mediumImpact();
                    vibrated = true;
                    displaySearchWidget = true;
                  }
                }
                if (scrollController.offset > -threshold) {
                  vibrated = false;
                  displaySearchWidget = false;
                }
                return CustomPaint(
                  painter: SearchIconPainter(
                    progress: scrollController.offset,
                    threshold: threshold,
                  ),
                  size: MediaQuery.of(context).size,
                );
              },
            ),
            SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.star_rounded,
                          color: Colors.yellow,
                          size: 32,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Today',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black38,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Text(
                          '6:00 AM Tennis',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text('9:00 AM Meeting'),
                      ],
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: showHighlight ? 50 : 0,
                    // color: Colors.lightGreen,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showHighlight = !showHighlight;
                        });
                      },
                      child: const Center(
                        child: Text('highlight', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  ...todos.map(
                    (e) => TodoItemWidget(item: e, key: UniqueKey()),
                  ),
                ],
              ),
            ),
            if (displaySearchWidget) searchWidget(),
          ],
        ),
      ),
    );
  }

  Widget searchWidget() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      height: displaySearchWidget ? h * .3 : 100,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.blueGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Icon(Icons.search_rounded),
                Text('Quick Find'),
                Spacer(),
                Text('Cancel'),
              ],
            ),
          ),
          Text(
            'Recent',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(),
          Row(children: [Icon(Icons.star_rounded), const SizedBox(width: 8), Text('Today')]),
          Row(children: [Icon(Icons.inbox), const SizedBox(width: 8), Text('Inbox')]),
          Row(children: [Icon(Icons.gif_box_rounded), const SizedBox(width: 8), Text('Someday')]),
          Row(children: [
            Icon(Icons.calendar_today_sharp),
            const SizedBox(width: 8),
            Text('Upcoming')
          ]),
          Spacer(),
          Center(child: Text('Quickly switch lists, find to-dos,\nsearch for tags...')),
          Spacer(),
        ],
      ),
    );
    // return OpenContainer(
    //   closedBuilder: (
    //     BuildContext context,
    //     void Function() action,
    //   ) {
    //     return Container(
    //       height: 40,
    //       child: Column(children: [
    //         Container(
    //           height: 40,
    //           child: Row(
    //             children: [
    //               Icon(Icons.search_rounded),
    //               Text('Quick Find'),
    //               Spacer(),
    //               Text('Cancel'),
    //             ],
    //           ),
    //         ),
    //       ]),
    //     );
    //   },
    //   openBuilder: (
    //     BuildContext context,
    //     void Function({Object? returnValue}) action,
    //   ) {
    //     return Container(
    //       height: 200,
    //       child: Column(
    //         children: [
    //           Container(
    //             height: 40,
    //             child: Row(
    //               children: [
    //                 Icon(Icons.search_rounded),
    //                 Text('Quick Find'),
    //                 Spacer(),
    //                 Text('Cancel'),
    //               ],
    //             ),
    //           ),
    //           Text('Recent'),
    //           Divider(),
    //           Row(children: [Icon(Icons.star_rounded), Text('Today')]),
    //           Row(children: [Icon(Icons.inbox), Text('Inbox')]),
    //           Row(children: [Icon(Icons.gif_box_rounded), Text('Someday')]),
    //           Row(children: [Icon(Icons.calendar_today_sharp), Text('Upcoming')]),
    //           Text('Quickly switch lists, find to-dos,\nsearch for tags...'),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}

class TodoItem {
  String title;
  String? content;

  TodoItem(this.title, {this.content});
}

class ThingsState with ChangeNotifier {
  bool _itemExpanded = false;
  bool _searchBarExpanded = false;

  bool get isItemExpanded => _itemExpanded;

  bool get isSearchBarExpanded => _searchBarExpanded;

  set isItemExpanded(bool value) {
    _itemExpanded = value;
    notifyListeners();
  }

  set isSearchBarExpanded(bool value) {
    _searchBarExpanded = value;
    notifyListeners();
  }
}
