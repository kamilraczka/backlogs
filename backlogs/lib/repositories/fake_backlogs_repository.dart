import 'package:backlogs/models/backlog.dart';
import 'package:flutter/material.dart';
import 'contracts/backlogs_repository.dart';

class FakeBacklogsRepository implements BacklogsRepository {
  FakeBacklogsRepository() {
    _backlogs = <Backlog>[
      Backlog(icon: Icons.event_note, title: 'All', id: 0),
      Backlog(icon: Icons.wallpaper, title: 'Passion', id: 1),
      Backlog(icon: Icons.school, title: 'School', id: 2),
      Backlog(icon: Icons.work, title: 'Work', id: 3),
      Backlog(icon: Icons.home, title: 'Home', id: 4),
      Backlog(icon: Icons.watch, title: 'Asaps', id: 5),
      Backlog(icon: Icons.group, title: 'Friends', id: 6),
      Backlog(icon: Icons.palette, title: 'Painting', id: 7),
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
