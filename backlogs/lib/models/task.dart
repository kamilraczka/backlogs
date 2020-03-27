import 'package:flutter/material.dart';

class Task {
  int id;
  int backlogId;
  String description;
  bool isDone;

  Task({
    @required this.id,
    @required this.backlogId,
    @required this.description,
    this.isDone = false,
  });
}
