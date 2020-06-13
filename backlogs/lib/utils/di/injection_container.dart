import 'package:backlogs/blocs/blocs.dart';
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
  sl.registerFactory<ApplicationBlocDelegate>(() => ApplicationBlocDelegate());
}
