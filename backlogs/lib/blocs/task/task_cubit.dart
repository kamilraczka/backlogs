import 'package:backlogs/models/task.dart';
import 'package:backlogs/data/data.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final BacklogsRepository repository;

  TaskCubit(this.repository)
      : assert(repository != null),
        super(TaskInitial());

  Future<void> addTask(Task task) async {
    emit(TaskLoadInProgress());
    await repository.addTask(task);
    emit(TaskSuccessfulChange());
  }

  Future<void> updateTask(Task task) async {
    emit(TaskLoadInProgress());
    await repository.updateTask(task);
    emit(TaskSuccessfulChange());
  }

  Future<void> deleteTask(String taskId, int backlogId) async {
    emit(TaskLoadInProgress());
    await repository.deleteTask(taskId, backlogId);
    emit(TaskSuccessfulChange());
  }

  Future<void> toggleTask(String taskId, int backlogId) async {
    emit(TaskLoadInProgress());
    await repository.toggleTask(taskId, backlogId);
    emit(TaskSuccessfulChange());
  }
}
