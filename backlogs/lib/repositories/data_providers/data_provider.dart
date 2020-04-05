import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';

class DataProvider {
  List<Backlog> _backlogs;

  DataProvider() {
    _backlogs = <Backlog>[Backlog(id: 0, icon: Icons.adb, title: 'Apps')];
  }

  Future<List<Backlog>> readBacklogs() {
    return Future.delayed(Duration(seconds: 1), () {
      return _backlogs;
    });
  }

  Future<List<Task>> readTasks({int backlogId}) {
    return Future.delayed(Duration(seconds: 1), () {
      return _backlogs
          .where((backlog) {
            return backlog.id == backlogId;
          })
          .first
          .tasks;
    });
  }

  Future createData<T>(T data, [Object argument]) {
    return Future.delayed(Duration(seconds: 1), () {
      if (data is Backlog) {
        _backlogs.add(data);
      } else if (data is Task) {
        int backlogId = argument;
        var backlog = _backlogs.where((backlog) {
          return backlog.id == backlogId;
        }).first;
        backlog.tasks.add(data);
      }
    });
  }

  Future updateData<T>(T data) {
    return Future.delayed(Duration(seconds: 1), () {});
  }

  Future deleteData<T>(T data) {
    return Future.delayed(Duration(seconds: 1), () {});
  }
}
