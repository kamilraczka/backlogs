import 'package:backlogs/blocs/backlog/backlog_event.dart';
import 'package:backlogs/blocs/backlog/backlog_state.dart';
import 'package:backlogs/repositories/backlogs_repository.dart';
import 'package:bloc/bloc.dart';

class BacklogBloc extends Bloc<BacklogEvent, BacklogState> {
  final BacklogsRepository repository;

  BacklogBloc(this.repository) : assert(repository != null);

  @override
  BacklogState get initialState => BacklogLoadingList();

  @override
  Stream<BacklogState> mapEventToState(BacklogEvent event) async* {
    yield BacklogLoadingList();
    if (event is BacklogGetAll) {
      yield* _mapGetAllToState();
    }
  }

  Stream<BacklogState> _mapGetAllToState() async* {
    final backlogs = await repository.fetchItems();
    yield BacklogReceivedAll(backlogs);
  }
}
