import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/repositories/backlogs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'backlog_event.dart';
part 'backlog_state.dart';

class BacklogBloc extends Bloc<BacklogEvent, BacklogState> {
  final BacklogsRepository repository;

  BacklogBloc(this.repository) : assert(repository != null);

  @override
  BacklogState get initialState => BacklogLoadInProgress();

  @override
  Stream<BacklogState> mapEventToState(BacklogEvent event) async* {
    yield BacklogLoadInProgress();
    if (event is BacklogLoadedAll) {
      yield* _mapGetAllToState();
    }
  }

  Stream<BacklogState> _mapGetAllToState() async* {
    final backlogs = await repository.fetchItems();
    yield BacklogLoadSuccess(backlogs);
  }
}
