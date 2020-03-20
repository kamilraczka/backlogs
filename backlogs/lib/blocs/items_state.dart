import 'package:backlogs/models/item.dart';

abstract class ItemsState {
  const ItemsState();
}

class ItemsInitial extends ItemsState {
  const ItemsInitial();
}

class ItemsReceived extends ItemsState {
  final List<Item> items;

  const ItemsReceived(this.items);
}
