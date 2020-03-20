import 'package:backlogs/models/item.dart';

abstract class ItemsRepository {
  Future<List<Item>> fetchItems(int backlogId);
}
