import 'package:backlogs/blocs/items_event.dart';
import 'package:backlogs/blocs/items_state.dart';
import 'package:backlogs/repositories/items_repository.dart';
import 'package:bloc/bloc.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemsState> {
  final ItemsRepository repository;

  ItemsBloc(this.repository);

  @override
  ItemsState get initialState => ItemsLoading();

  @override
  Stream<ItemsState> mapEventToState(ItemsEvent event) async* {
    if (event is ItemsGetAll) {
      final items = await repository.fetchItems(event.backlogId);
      yield ItemsReceived(items);
    } else if (event is ItemsAddItem) {
      repository.addItem(event.item);
      final items = await repository.fetchItems(1);
      yield ItemsReceived(items);
    }
  }
}
