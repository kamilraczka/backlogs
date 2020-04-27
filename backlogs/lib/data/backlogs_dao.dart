import 'package:sembast/sembast.dart';
import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/data/app_database.dart';

class BacklogsDao {
  static const String backlogStoreName = 'backlogs';
  final _backlogsStore = intMapStoreFactory.store(backlogStoreName);

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future<int> insert(Backlog backlog) async {
    return await _backlogsStore.add(await _db, backlog.toMap());
  }

  Future update(Backlog backlog) async {
    final finder = Finder(filter: Filter.byKey(backlog.id));
    await _backlogsStore.update(await _db, backlog.toMap(), finder: finder);
  }

  Future delete(int backlogId) async {
    final finder = Finder(filter: Filter.byKey(backlogId));
    await _backlogsStore.delete(await _db, finder: finder);
  }

  Future<List<Backlog>> readAllByTitle() async {
    final finder = Finder(sortOrders: [
      SortOrder('title'),
    ]);
    final recordSnapshots = await _backlogsStore.find(
      await _db,
      finder: finder,
    );
    return recordSnapshots.map((snapshot) {
      final backlog = Backlog.fromMap(snapshot.value);
      backlog.id = snapshot.key;
      return backlog;
    }).toList();
  }
}
