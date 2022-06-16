import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_item_widget.dart';

class ThingsApp extends StatefulWidget {
  const ThingsApp({Key? key}) : super(key: key);

  @override
  _ThingsAppState createState() => _ThingsAppState();
}

class _ThingsAppState extends State<ThingsApp> {
  List<TodoItem> todos = [];
  ThingsState state = ThingsState();
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    List.generate(100, (index) {
      todos.add(TodoItem('$index'));
    });
    // scrollController = ScrollController()
    //   ..addListener(() {
    //     setState(() {});
    //   });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Transform.rotate(
              angle: pi / 2,
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider.value(
        value: state,
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (details) {
                print('scroll details $details');
                return true;
              },
              child: searchWidget(),
            ),
            SingleChildScrollView(
              controller: scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    children: const [
                      Icon(Icons.star_rounded),
                      SizedBox(width: 8),
                      Text(
                        'Today',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ],
                  ),
                  ...todos.map(
                    (e) => GestureDetector(
                      onTap: () {
                        state.isItemExpanded = !state.isItemExpanded;
                      },
                      child: TodoItemWidget(item: e),
                    ),
                  ),
                ],
              ),
            ),
            if (state.isItemExpanded)
              Positioned(
                bottom: 10,
                child: Row(
                  children: const [
                    Text('move'),
                    Icon(CupertinoIcons.trash),
                    Icon(Icons.more_horiz_rounded),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget searchWidget() {
    return OpenContainer(
      closedBuilder: (
        BuildContext context,
        void Function() action,
      ) {
        return Container(
          height: 40,
          child: Column(children: [
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
          ]),
        );
      },
      openBuilder: (
        BuildContext context,
        void Function({Object? returnValue}) action,
      ) {
        return Container(
          height: 200,
          child: Column(
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
              Text('Recent'),
              Divider(),
              Row(children: [Icon(Icons.star_rounded), Text('Today')]),
              Row(children: [Icon(Icons.inbox), Text('Inbox')]),
              Row(children: [Icon(Icons.gif_box_rounded), Text('Someday')]),
              Row(children: [
                Icon(Icons.calendar_today_sharp),
                Text('Upcoming')
              ]),
              Text('Quickly switch lists, find to-dos,\nsearch for tags...'),
            ],
          ),
        );
      },
    );
  }
}

class TodoItem {
  String title;
  String? content;

  TodoItem(this.title, {this.content});
}

class ThingsState with ChangeNotifier {
  bool _itemExpanded = false;

  bool get isItemExpanded => _itemExpanded;

  set isItemExpanded(bool value) {
    _itemExpanded = value;
    notifyListeners();
  }
}
