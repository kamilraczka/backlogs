import 'package:backlogs/blocs/backlog/backlog_bloc.dart';
import 'package:backlogs/blocs/task/task_bloc.dart';
import 'package:backlogs/data/data.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // daos
  sl.registerSingleton<BacklogsDao>(BacklogsDao());
  // repositories
  sl.registerSingleton<BacklogsRepository>(BacklogsRepository(sl()));
  // blocs
  sl.registerFactory<BacklogBloc>(() => BacklogBloc(sl()));
  sl.registerFactory<TaskBloc>(() => TaskBloc(sl()));
}
