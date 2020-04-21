import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';

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
        'iconCodePoint': iconData.codePoint,
        'iconFontFamily': iconData.fontFamily,
        'iconFontPackage': iconData.fontPackage,
        'tasks': tasks.map((element) => element.toMap()).toList(),
      };

  static Backlog fromMap(Map<String, dynamic> entity) {
    final rawListOfTasks = entity['tasks'] as List;
    return Backlog(
      title: entity['title'],
      iconData: IconData(
        entity['iconCodePoint'],
        fontFamily: entity['iconFontFamily'],
        fontPackage: entity['iconFontPackage'],
      ),
      tasks: rawListOfTasks.map((element) => Task.fromMap(element)).toList(),
    );
  }
}
