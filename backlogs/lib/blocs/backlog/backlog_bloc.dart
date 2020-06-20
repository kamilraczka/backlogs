import 'dart:async';

import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/data/data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'backlog_event.dart';
part 'backlog_state.dart';

class BacklogBloc extends Bloc<BacklogEvent, BacklogState> {
  final BacklogsRepository repository;
  final TaskBloc taskBloc;
  StreamSubscription taskBlocSubscription;

  BacklogBloc(this.repository, [this.taskBloc]) : assert(repository != null) {
    if (taskBloc != null) {
      taskBlocSubscription = taskBloc.listen((taskBlocState) {
        if (taskBlocState is TaskSuccessfulChange) {
          add(BacklogFetched((state as BacklogLoadSuccess).backlogs.first.id));
        }
      });
    }
  }

  @override
  BacklogState get initialState => BacklogLoadInProgress();

  @override
  Stream<BacklogState> mapEventToState(BacklogEvent event) async* {
    if (event is BacklogListFetched) {
      yield* _mapListFetchedToState();
    } else if (event is BacklogFetched) {
      yield* _mapFetchedToState(event.backlogId);
    } else if (event is BacklogAdded) {
      yield* _mapAddedToState(event.backlog);
    } else if (event is BacklogEdited) {
      yield* _mapEditedToState(event.backlog);
    } else if (event is BacklogDeleted) {
      yield* _mapDeletedToState(event.backlogId);
    }
  }

  @override
  Future<void> close() {
    if (taskBlocSubscription != null) taskBlocSubscription.cancel();
    return super.close();
  }

  Stream<BacklogState> _mapListFetchedToState() async* {
    final backlogs = await repository.fetchBacklogs();
    yield BacklogLoadSuccess(backlogs);
  }

  Stream<BacklogState> _mapFetchedToState(int backlogId) async* {
    yield BacklogLoadInProgress();
    final backlog = await repository.fetchBacklog(backlogId);
    final backlogs = List<Backlog>();
    backlogs.add(backlog);
    yield BacklogLoadSuccess(backlogs);
  }

  Stream<BacklogState> _mapAddedToState(Backlog backlog) async* {
    await repository.addBacklog(backlog);
    add(BacklogListFetched());
  }

  Stream<BacklogState> _mapEditedToState(Backlog backlog) async* {
    await repository.updateBacklog(backlog);
    add(BacklogListFetched());
  }

  Stream<BacklogState> _mapDeletedToState(int backlogId) async* {
    await repository.deleteBacklog(backlogId);
    add(BacklogListFetched());
  }
}
