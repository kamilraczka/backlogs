part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {
  const TaskEvent();
}

class TaskAdded extends TaskEvent {
  final Task task;
  const TaskAdded(this.task);
}

class TaskUpdated extends TaskEvent {
  final Task task;
  const TaskUpdated(this.task);
}

class TaskDeleted extends TaskEvent {
  final String taskId;
  const TaskDeleted(this.taskId);
}
