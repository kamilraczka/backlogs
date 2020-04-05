import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/repositories/data_providers/data_provider.dart';

class BacklogsRepository {
  final DataProvider _dataProvider;

  BacklogsRepository(this._dataProvider) : assert(_dataProvider != null);

  Future<List<Backlog>> fetchItems() async {
    return await _dataProvider.readBacklogs();
  }
}
