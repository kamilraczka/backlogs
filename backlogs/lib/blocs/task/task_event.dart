import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class TaskGetAll extends TaskEvent {
  final int backlogId;

  const TaskGetAll({@required this.backlogId});
}

class TaskAddOne extends TaskEvent {
  final Task task;

  const TaskAddOne({@required this.task});
}

class TaskToggle extends TaskEvent {
  final Task task;
  final bool state;

  const TaskToggle({
    @required this.task,
    @required this.state,
  });
}
