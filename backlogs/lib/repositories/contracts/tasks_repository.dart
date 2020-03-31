import 'package:backlogs/models/task.dart';

abstract class TasksRepository {
  Future<List<Task>> fetchItems(int backlogId);
  Future addSingleItem(Task task);
}
