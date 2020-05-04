part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {
  const TaskEvent();
}

class TaskLoadedAll extends TaskEvent {
  final int backlogId;

  const TaskLoadedAll({@required this.backlogId});
}

class TaskAdded extends TaskEvent {
  final Task task;

  const TaskAdded(this.task);
}

class TaskDeleted extends TaskEvent {
  final Task task;

  const TaskDeleted(this.task);
}

class TaskToggled extends TaskEvent {
  final Task task;
  final bool state;

  const TaskToggled(
    this.task,
    this.state,
  );
}
