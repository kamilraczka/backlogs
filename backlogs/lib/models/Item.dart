import 'package:flutter/material.dart';

class Item {
  int id;
  String description;
  bool isDone;

  Item({
    @required this.id,
    @required this.description,
    this.isDone,
  });
}
