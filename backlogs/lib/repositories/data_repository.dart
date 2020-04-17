import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/models/task.dart';
import 'package:backlogs/repositories/backlogs_dao.dart';

class DataRepository {
  final BacklogsDao _backlogsDao;
  List<Backlog> _backlogs;

  DataRepository(this._backlogsDao) : assert(_backlogsDao != null);

  Future<List<Backlog>> fetchBacklogs() async {
    if (_backlogs == null) {
      _backlogs = await _backlogsDao.readAllByTitle();
    }
    return _backlogs;
  }

  Future<List<Task>> fetchTasks(int backlogId) async {
    if (_backlogs == null) {
      _backlogs = await _backlogsDao.readAllByTitle();
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
    return _backlogsDao.update(backlog);
  }

  Future addBacklog(Backlog backlog) {
    _backlogs.add(backlog);
    return _backlogsDao.insert(backlog);
  }
}
