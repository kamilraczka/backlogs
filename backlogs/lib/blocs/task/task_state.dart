part of 'task_bloc.dart';

@immutable
abstract class TaskState {
  const TaskState();
}

class TaskLoadInProgress extends TaskState {
  const TaskLoadInProgress();
}

class TaskLoadSuccess extends TaskState {
  final List<Task> tasks;

  const TaskLoadSuccess(this.tasks);
}
