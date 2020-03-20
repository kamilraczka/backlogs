import 'package:backlogs/models/item.dart';
import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  Task({this.holdedItem, this.onCheckboxChanged})
      : super(key: ObjectKey(holdedItem));

  final Item holdedItem;
  final Function(bool) onCheckboxChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              holdedItem.description,
            ),
          ),
          Checkbox(
            value: holdedItem.isDone,
            onChanged: onCheckboxChanged,
          )
        ],
      ),
    );
  }
}
