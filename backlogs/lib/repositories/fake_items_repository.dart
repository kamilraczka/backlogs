import 'package:backlogs/models/item.dart';
import 'package:backlogs/repositories/items_repository.dart';

class FakeItemsRepository implements ItemsRepository {
  var _items = List<Item>();
  @override
  Future<List<Item>> fetchItems(int backlogId) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return _items;
      },
    );
  }

  @override
  Future addItem(Item item) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        _items.add(item);
      },
    );
  }
}
