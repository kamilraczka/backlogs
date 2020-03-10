import 'package:backlogs/models/Item.dart';
import 'package:backlogs/utilities/colors.dart';
import 'package:flutter/material.dart';

class BacklogScreen extends StatelessWidget {
  var items = <Item>[Item('test', true)];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 256.0,
            title: Text('SliverAppBar text'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _buildTask(items.first),
                childCount: 20),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        backgroundColor: ColorsLibrary.primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildTask(Item item) {
    return Row(
      children: <Widget>[
        Text(item.description),
        Checkbox(
          value: item.isDone,
          onChanged: null,
        )
      ],
    );
  }
}
