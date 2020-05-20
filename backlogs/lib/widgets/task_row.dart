import 'package:backlogs/models/models.dart';
import 'package:flutter/material.dart';

class TaskRow extends StatelessWidget {
  final Task task;

  TaskRow({@required this.task})
      : assert(task != null),
        super(key: ObjectKey(task));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              task.description,
            ),
          ),
        ],
      ),
    );
  }
}
