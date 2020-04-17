import 'package:backlogs/models/task.dart';
import 'package:backlogs/data/backlogs_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final BacklogsRepository repository;

  TaskBloc(this.repository) : assert(repository != null);

  @override
  TaskState get initialState => TaskLoadInProgress();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is TaskLoadedAll) {
      yield* _mapGetAllToState(event);
    } else if (event is TaskAdded) {
      yield* _mapAddItemToState(event);
    }
  }

  Stream<TaskState> _mapGetAllToState(TaskLoadedAll event) async* {
    final tasks = await repository.fetchTasks(event.backlogId);
    yield TaskLoadSuccess(tasks);
  }

  Stream<TaskState> _mapAddItemToState(TaskAdded event) async* {
    await repository.addTaskToBacklog(event.task);
    add(TaskLoadedAll(backlogId: event.task.backlogId));
  }
}
