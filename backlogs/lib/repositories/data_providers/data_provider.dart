import 'package:backlogs/models/backlog.dart';
import 'package:flutter/material.dart';

class DataProvider {
  List<Backlog> _backlogs;

  DataProvider() {
    _backlogs = <Backlog>[Backlog(id: 0, icon: Icons.adb, title: 'Apps')];
  }

  Future<List<Backlog>> readBacklogs() {
    // It could be generic but casing during return ("return _backlogs as List<T>") doesn't work
    return Future.delayed(Duration(seconds: 1), () {
      return _backlogs;
    });
  }

  Future updateData<T>(T data) {
    return Future.delayed(Duration(seconds: 1), () {
      if (T is List<Backlog>) {
        _backlogs = data as List<Backlog>;
      }
    });
  }

  Future deleteData<T>(T data) {
    return Future.delayed(Duration(seconds: 1), () {});
  }
}
