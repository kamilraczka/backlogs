import 'package:backlogs/screens/backlog/widgets/Task.dart';
import 'package:backlogs/screens/creation/Creation.dart';
import 'package:backlogs/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:backlogs/models/Item.dart';

class Backlog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BacklogState();
}

class _BacklogState extends State<Backlog> {
  List<Item> _items = <Item>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 196.0,
            title: Text('All tasks'),
            backgroundColor: ColorsLibrary.primaryColor,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Task(
                    holdedItem: _items[index],
                    onCheckboxChanged: null,
                  );
                },
                childCount: _items.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: ColorsLibrary.primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Creation(
            onCreatePressed: _createTask,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _createTask(String text) {
    setState(() {
      _items.add(
        Item(text, false),
      );
    });
  }
}
