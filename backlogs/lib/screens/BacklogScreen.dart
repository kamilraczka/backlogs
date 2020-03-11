import 'package:backlogs/models/Item.dart';
import 'package:backlogs/utilities/colors.dart';
import 'package:flutter/material.dart';

class BacklogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  var items = <Item>[
    Item('first item', true),
    Item('second item', true),
    Item('third item', true),
  ];

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
                  for (var item in items) {
                    _buildTaskRow(item);
                  }
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFabPressed(),
        backgroundColor: ColorsLibrary.primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildTaskRow(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              item.description,
            ),
          ),
          Checkbox(
            value: item.isDone,
            onChanged: null,
          )
        ],
      ),
    );
  }

  void _onFabPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text('Test tile'),
              onTap: () {
                _createTask("createTaskMock");
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _createTask(String text) {
    setState(() {
      items.add(Item(text, false));
    });
  }
}
