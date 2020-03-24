import 'package:backlogs/models/item.dart';
import 'package:flutter/material.dart';

abstract class ItemsEvent {
  const ItemsEvent();
}

class ItemsGetAll extends ItemsEvent {
  final int backlogId;

  const ItemsGetAll({@required this.backlogId});
}

class ItemsAddItem extends ItemsEvent {
  final Item item;

  const ItemsAddItem({@required this.item});
}

class ItemToggle extends ItemsEvent {
  final Item item;
  final bool state;

  const ItemToggle({
    @required this.item,
    @required this.state,
  });
}
