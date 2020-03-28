import 'package:backlogs/models/task.dart';
import 'contracts/tasks_repository.dart';

class FakeTasksRepository implements TasksRepository {
  FakeTasksRepository() {
    _tasks = List<Task>();
  }

  List<Task> _tasks;

  @override
  Future<List<Task>> fetchItems(int backlogId) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return _tasks;
      },
    );
  }

  @override
  Future addSingleItem(Task task) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        _tasks.add(task);
      },
    );
  }
}
