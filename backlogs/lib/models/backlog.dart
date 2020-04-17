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

  Map<String, dynamic> toMap() => {
        'title': title,
        'iconCodePoint': iconData.codePoint,
        'iconFontFamily': iconData.fontFamily,
        'iconFontPackage': iconData.fontPackage,
        'colorValue': color.value,
        'tasks': tasks.map((element) => element.toMap()).toList(),
      };

  static Backlog fromMap(Map<String, dynamic> entity) {
    final rawListOfTasks = entity['tasks'] as List;
    final tasks =
        rawListOfTasks.map((element) => Task.fromMap(element)).toList();
    return Backlog(
      title: entity['title'],
      iconData: IconData(
        entity['iconCodePoint'],
        fontFamily: entity['iconFontFamily'],
        fontPackage: entity['iconFontPackage'],
      ),
      color: Color(entity['colorValue']),
      tasks: tasks,
    );
  }
}
