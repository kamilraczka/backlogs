import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Task {
  String id;
  String backlogId;
  String description;
  bool isDone;

  Task({
    @required this.backlogId,
    @required this.description,
    this.isDone = false,
  }) {
    this.id = Uuid().v4();
  }
}
