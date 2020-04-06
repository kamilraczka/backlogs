import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Backlog {
  String id;
  String title;
  IconData icon;
  Color color;
  List<Task> tasks;

  Backlog({
    @required this.title,
    this.icon,
    this.color,
  }) {
    this.id = Uuid().v4();
    this.tasks = List<Task>();
  }
}
