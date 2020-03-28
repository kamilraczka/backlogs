import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  Tile({this.backlog}) : super(key: ObjectKey(backlog));

  final Backlog backlog;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.red[100],
      child: Column(
        children: <Widget>[
          Icon(backlog.icon),
          Text(backlog.title),
          Text('23 Tasks'),
        ],
      ),
    );
  }
}
