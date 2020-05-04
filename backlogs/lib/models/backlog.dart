import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';
import 'package:backlogs/extensions/e_extensions.dart';

class Backlog {
  int id;
  String title;
  IconData iconData;
  List<Task> tasks;

  Backlog({
    @required this.title,
    @required this.iconData,
    this.tasks,
    this.id,
  }) {
    if (tasks == null) {
      this.tasks = List<Task>();
    }
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'iconData': iconData.mapValue,
        'tasks': tasks.map((element) => element.toMap()).toList(),
      };

  static Backlog fromMap(Map<String, dynamic> entity) {
    final rawListOfTasks = entity['tasks'] as List;
    final iconData = IconDataExtension.fromMap(entity['iconData']);
    return Backlog(
      title: entity['title'],
      iconData: iconData,
      tasks: rawListOfTasks.map((element) => Task.fromMap(element)).toList(),
    );
  }
}
