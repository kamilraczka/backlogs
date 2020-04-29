import 'dart:async';

import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/data/backlogs_repository.dart';
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
    if (event is BacklogLoadedAll) {
      yield* _mapLoadedAllToState();
    } else if (event is BacklogAdded) {
      yield* _mapAddedToState(event.backlog);
    } else if (event is BacklogEdited) {
      yield* _mapEditedToState(event.backlog);
    } else if (event is BacklogDeleted) {
      yield* _mapDeletedToState(event.backlogId);
    }
  }

  Stream<BacklogState> _mapLoadedAllToState() async* {
    final backlogs = await repository.fetchBacklogs();
    yield BacklogLoadSuccess(backlogs);
  }

  Stream<BacklogState> _mapAddedToState(Backlog backlog) async* {
    await repository.addBacklog(backlog);
    add(BacklogLoadedAll());
  }

  Stream<BacklogState> _mapEditedToState(Backlog backlog) async* {
    await repository.updateBacklog(backlog);
    add(BacklogLoadedAll());
  }

  Stream<BacklogState> _mapDeletedToState(int backlogId) async* {
    await repository.deleteBacklog(backlogId);
    add(BacklogLoadedAll());
  }
}
