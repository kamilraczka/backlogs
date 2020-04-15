import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';

class Backlog {
  int id;
  String title;
  IconData iconData;
  Color color;
  List<Task> tasks;

  Backlog({
    @required this.title,
    @required this.iconData,
    @required this.color,
    this.tasks,
  }) {
    if (tasks == null) {
      this.tasks = List<Task>();
    }
  }

  Map<String, dynamic> toEntity() {
    return {
      'title': title,
      'iconData': iconData,
      'color': color,
      'tasks': tasks,
    };
  }

  static Backlog fromEntity(Map<String, dynamic> entity) {
    return Backlog(
      title: entity['title'],
      iconData: entity['iconData'],
      color: entity['color'],
      tasks: entity['tasks'],
    );
  }
}
