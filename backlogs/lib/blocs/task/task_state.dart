import 'package:backlogs/models/task.dart';

abstract class TaskState {
  const TaskState();
}

class TaskLoadingList extends TaskState {
  const TaskLoadingList();
}

class TaskReceivedAll extends TaskState {
  final List<Task> tasks;

  const TaskReceivedAll(this.tasks);
}
