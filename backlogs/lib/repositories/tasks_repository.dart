import 'package:backlogs/models/task.dart';
import 'package:backlogs/repositories/data_providers/data_provider.dart';

class TasksRepository {
  final DataProvider _dataProvider;

  TasksRepository(this._dataProvider) : assert(_dataProvider != null);

  Future<List<Task>> fetchItems(int backlogId) async {
    return _dataProvider.readTasks(backlogId: backlogId);
  }

  Future addSingleItem(Task task) {
    return _dataProvider.createData(task, task.backlogId);
  }
}
