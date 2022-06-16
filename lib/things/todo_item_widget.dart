import 'package:flutter/material.dart';
import 'package:flutter_demo/things/things_app.dart';
import 'package:provider/provider.dart';

class TodoItemWidget extends StatefulWidget {
  final TodoItem item;

  const TodoItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  State<TodoItemWidget> createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThingsState>(
      builder: (context, state, child) => GestureDetector(
        onTap: () {
          state.isItemExpanded = !state.isItemExpanded;
        },
        child: AnimatedContainer(
          color: state.isItemExpanded ? Colors.black12 : Colors.black54,
          duration: const Duration(microseconds: 200),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.check_box_outline_blank_rounded),
                  Text(
                    widget.item.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              if (state.isItemExpanded) Text('Notes'),
              if (state.isItemExpanded) Text('o todo item'),
              if (state.isItemExpanded)
                Row(
                  children: const [
                    Icon(Icons.star_rounded),
                    Text('Today'),
                    Spacer(),
                    Icon(Icons.bookmark_border_outlined),
                    Icon(Icons.flag_outlined),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
