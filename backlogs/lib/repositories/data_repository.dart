import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/models/task.dart';
import 'package:backlogs/repositories/data_providers/data_provider.dart';

class DataRepository {
  final DataProvider _dataProvider;
  List<Backlog> _backlogs;

  DataRepository(this._dataProvider) : assert(_dataProvider != null);

  Future<List<Backlog>> fetchBacklogs() async {
    if (_backlogs == null) {
      _backlogs = await _dataProvider.readBacklogs();
    }
    return _backlogs;
  }

  Future<List<Task>> fetchTasks(int backlogId) async {
    if (_backlogs == null) {
      _backlogs = await _dataProvider.readBacklogs();
    }
    return _backlogs
        .where((backlog) {
          return backlog.id == backlogId;
        })
        .first
        .tasks;
  }

  Future addTaskToBacklog(Task task) {
    var backlog = _backlogs.where((backlog) {
      return backlog.id == task.backlogId;
    }).first;
    backlog.tasks.add(task);
    return _dataProvider.updateData(_backlogs);
  }
}
