import 'package:backlogs/models/task.dart';
import 'package:backlogs/repositories/tasks_repository.dart';

class FakeTasksRepository implements TasksRepository {
  var _tasks = List<Task>();
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
