import 'package:backlogs/models/backlog.dart';

abstract class BacklogsRepository {
  Future<List<Backlog>> fetchItems();
  Future addSingleItem(Backlog backlog);
  Future deleteSingleItem(int backlogId);
}
