import 'package:backlogs/blocs/task/task_event.dart';
import 'package:backlogs/blocs/task/task_state.dart';
import 'package:backlogs/repositories/tasks_repository.dart';
import 'package:bloc/bloc.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TasksRepository repository;

  TaskBloc(this.repository);

  @override
  TaskState get initialState => TaskLoadingList();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    yield TaskLoadingList();
    if (event is TaskGetAll) {
      yield* _mapGetAllToState(event);
    } else if (event is TaskAddOne) {
      yield* _mapAddItemToState(event);
    }
  }

  Stream<TaskState> _mapGetAllToState(TaskGetAll event) async* {
    final tasks = await repository.fetchItems(event.backlogId);
    yield TaskReceivedAll(tasks);
  }

  Stream<TaskState> _mapAddItemToState(TaskAddOne event) async* {
    repository.addSingleItem(event.task);
    add(TaskGetAll(backlogId: event.task.backlogId));
  }
}
