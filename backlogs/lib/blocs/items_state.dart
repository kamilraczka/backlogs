import 'package:backlogs/models/item.dart';

abstract class ItemsState {
  const ItemsState();
}

class ItemsLoading extends ItemsState {
  const ItemsLoading();
}

class ItemsReceived extends ItemsState {
  final List<Item> items;

  const ItemsReceived(this.items);
}
