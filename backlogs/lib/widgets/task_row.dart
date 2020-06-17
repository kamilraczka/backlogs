import 'package:backlogs/models/models.dart';
import 'package:flutter/material.dart';

class TaskRow extends StatelessWidget {
  final Task task;
  final Function onCheckboxChanged;
  final Function({Task task}) onTextTap;

  TaskRow({
    @required this.task,
    @required this.onTextTap,
    @required this.onCheckboxChanged,
  })  : assert(task != null),
        assert(onTextTap != null),
        assert(onCheckboxChanged != null),
        super(key: ObjectKey(task));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Text(
                task.description,
              ),
              onTap: () => onTextTap(task: task),
            ),
          ),
          Checkbox(
            value: task.isArchived,
            onChanged: (newVal) => onCheckboxChanged(),
          ),
        ],
      ),
    );
  }
}
