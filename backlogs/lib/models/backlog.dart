import 'package:backlogs/models/task.dart';
import 'package:flutter/material.dart';

class Backlog {
  int id;
  String title;
  List<Task> tasks;
  IconData icon;

  Backlog({
    @required this.id,
    @required this.title,
    @required this.icon,
  }) {
    this.tasks = List<Task>();
  }
}
