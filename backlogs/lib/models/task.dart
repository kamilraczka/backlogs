import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Task {
  String id;
  int backlogId;
  String description;
  bool isArchived;

  Task({
    @required this.backlogId,
    @required this.description,
    this.isArchived = false,
  }) : this.id = Uuid().v4();

  Map<String, dynamic> toMap() => {
        'id': id,
        'backlogId': backlogId,
        'description': description,
        'isArchived': isArchived,
      };

  static Task fromMap(Map<String, dynamic> map) {
    return Task(
      backlogId: map['backlogId'],
      description: map['description'],
      isArchived: map['isArchived'],
    );
  }
}
