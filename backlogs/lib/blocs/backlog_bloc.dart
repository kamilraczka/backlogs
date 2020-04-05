import 'dart:async';

import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/repositories/data_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'backlog_event.dart';
part 'backlog_state.dart';

class BacklogBloc extends Bloc<BacklogEvent, BacklogState> {
  final DataRepository repository;

  BacklogBloc(this.repository) : assert(repository != null);

  @override
  BacklogState get initialState => BacklogLoadInProgress();

  @override
  Stream<BacklogState> mapEventToState(BacklogEvent event) async* {
    yield BacklogLoadInProgress();
    if (event is BacklogLoadedAll) {
      yield* _mapLoadedAllToState();
    }
  }

  Stream<BacklogState> _mapLoadedAllToState() async* {
    final backlogs = await repository.fetchBacklogs();
    yield BacklogLoadSuccess(backlogs);
  }
}
