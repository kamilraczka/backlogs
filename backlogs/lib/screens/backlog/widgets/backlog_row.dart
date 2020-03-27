import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';

class BacklogRow extends StatelessWidget {
  BacklogRow({this.task, this.onCheckboxChanged}) : super(key: ObjectKey(task));

  final Task task;
  final Function(bool) onCheckboxChanged;

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
          Checkbox(
            value: task.isDone,
            onChanged: onCheckboxChanged,
          )
        ],
      ),
    );
  }
}
