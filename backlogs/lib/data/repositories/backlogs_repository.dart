import 'package:backlogs/models/models.dart';
import 'package:backlogs/data/daos/backlogs_dao.dart';
import 'package:flutter/widgets.dart';

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

  Future<Backlog> fetchBacklog(int backlogId) async {
    return _backlogs.where((element) => element.id == backlogId).first;
  }

  Future addBacklog(Backlog backlog) async {
    final snapshotKey = await _backlogsDao.insert(backlog);
    backlog.id = snapshotKey;
    _backlogs.add(backlog);
  }

  Future updateBacklog(Backlog updatedBacklog) async {
    await _backlogsDao.update(updatedBacklog);
    _backlogs = _backlogs
        .map((element) =>
            element.id == updatedBacklog.id ? updatedBacklog : element)
        .toList();
  }

  Future deleteBacklog(int backlogId) async {
    await _backlogsDao.delete(backlogId);
    _backlogs.removeWhere((backlog) => backlog.id == backlogId);
  }

  Future addTask(Task task) async {
    var updatedBacklog =
        _backlogs.where((element) => element.id == task.backlogId).first;
    updatedBacklog.tasks.add(task);
    await _backlogsDao.update(updatedBacklog);
  }

  Future updateTask(Task task) async {
    var updatedBacklog =
        _backlogs.where((element) => element.id == task.backlogId).first;
    updatedBacklog.tasks = updatedBacklog.tasks
        .map((element) => element.id == task.id ? task : element)
        .toList();
    await _backlogsDao.update(updatedBacklog);
  }

  Future deleteTask(String taskId, int backlogId) async {
    var updatedBacklog =
        _backlogs.where((element) => element.id == backlogId).first;
    updatedBacklog.tasks.removeWhere((element) => element.id == taskId);
    await _backlogsDao.update(updatedBacklog);
  }
}
