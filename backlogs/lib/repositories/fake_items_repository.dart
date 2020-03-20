import 'package:backlogs/models/item.dart';
import 'package:backlogs/repositories/items_repository.dart';

class FakeItemsRepository implements ItemsRepository {
  @override
  Future<List<Item>> fetchItems(int backlogId) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return <Item>[
          Item(
            id: 1,
            description: "Task with #1 number",
          ),
          Item(
            id: 2,
            description: "Task with #2 number",
          ),
          Item(
            id: 3,
            description: "Task with #3 number",
          ),
        ];
      },
    );
  }
}
