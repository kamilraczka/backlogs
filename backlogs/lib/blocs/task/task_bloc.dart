import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/task.dart';
import 'package:backlogs/data/data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final BacklogsRepository repository;

  TaskBloc(this.repository) : assert(repository != null);

  @override
  TaskState get initialState => TaskInitial();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is TaskAdded) {
      yield* _mapAddedToState(event);
    } else if (event is TaskUpdated) {
      yield* _mapUpdatedToState(event);
    }
  }

  Stream<TaskState> _mapAddedToState(TaskAdded event) async* {
    yield TaskLoadInProgress();
    await repository.addTask(event.task);
    yield TaskSuccessfulChange();
  }

  Stream<TaskState> _mapUpdatedToState(TaskUpdated event) async* {
    yield TaskLoadInProgress();
    await repository.updateTask(event.task);
    yield TaskSuccessfulChange();
  }
}
