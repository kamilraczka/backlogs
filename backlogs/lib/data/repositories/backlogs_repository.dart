import 'package:backlogs/models/models.dart';
import 'package:backlogs/data/daos/backlogs_dao.dart';

class BacklogsRepository {
  final BacklogsDao _backlogsDao;
  List<Backlog> _backlogs;

  BacklogsRepository(this._backlogsDao) : assert(_backlogsDao != null);

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

  Future addBacklog(Backlog backlog) async {
    final snapshotKey = await _backlogsDao.insert(backlog);
    backlog.id = snapshotKey;
    _backlogs.add(backlog);
  }

  Future updateBacklog(Backlog updatedBacklog) async {
    await _backlogsDao.update(updatedBacklog);
    var oldBacklog =
        _backlogs.firstWhere((backlog) => backlog.id == updatedBacklog.id);
    oldBacklog.title = updatedBacklog.title;
    oldBacklog.iconData = updatedBacklog.iconData;
  }

  Future deleteBacklog(int backlogId) async {
    await _backlogsDao.delete(backlogId);
    _backlogs.removeWhere((backlog) => backlog.id == backlogId);
  }
}
