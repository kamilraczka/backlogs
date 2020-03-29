import 'package:backlogs/models/backlog.dart';
import 'package:flutter/material.dart';

abstract class BacklogEvent {
  const BacklogEvent();
}

class BacklogGetAll extends BacklogEvent {
  const BacklogGetAll();

  @override
  String toString() {
    return 'Get all backlogs!';
  }
}

class BacklogAddOne extends BacklogEvent {
  final Backlog backlog;

  const BacklogAddOne({@required this.backlog});
}

class BacklogEditOne extends BacklogEvent {
  final Backlog backlog;

  const BacklogEditOne({@required this.backlog});
}

class BacklogDeleteOne extends BacklogEvent {
  final Backlog backlog;

  const BacklogDeleteOne({@required this.backlog});
}
