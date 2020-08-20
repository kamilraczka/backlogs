part of 'task_cubit.dart';

@immutable
abstract class TaskState {
  const TaskState();
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TaskLoadInProgress extends TaskState {
  const TaskLoadInProgress();
}

class TaskSuccessfulChange extends TaskState {
  const TaskSuccessfulChange();
}
