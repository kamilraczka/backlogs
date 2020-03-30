import 'package:backlogs/models/backlog.dart';
import 'package:flutter/material.dart';
import 'contracts/backlogs_repository.dart';

class FakeBacklogsRepository implements BacklogsRepository {
  FakeBacklogsRepository() {
    _backlogs = <Backlog>[
      Backlog(icon: Icons.wallpaper, title: 'All', id: 0),
    ];
  }

  List<Backlog> _backlogs;

  @override
  Future addSingleItem(Backlog backlog) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        _backlogs.add(backlog);
      },
    );
  }

  @override
  Future deleteSingleItem(int backlogId) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        try {
          _backlogs.removeAt(backlogId);
        } catch (exception) {
          print('Catched $exception');
        }
      },
    );
  }

  @override
  Future<List<Backlog>> fetchItems() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return _backlogs;
      },
    );
  }
}
