import 'package:backlogs/repositories/backlogs_repository.dart';
import 'package:backlogs/repositories/data_providers/data_provider.dart';
import 'package:backlogs/repositories/tasks_repository.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:backlogs/screens/backlog/backlog.dart';
import 'package:backlogs/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/backlog_bloc.dart';
import 'blocs/task_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = DataProvider();

    return MaterialApp(
      title: 'Backlogs Application',
      initialRoute: ApplicationRoutes.home.value,
      routes: {
        ApplicationRoutes.home.value: (context) {
          return BlocProvider(
            create: (context) => BacklogBloc(BacklogsRepository(dataProvider))
              ..add(BacklogLoadedAll()),
            child: HomeScreen(),
          );
        },
        ApplicationRoutes.backlog.value: (context) {
          return BlocProvider(
            create: (context) => TaskBloc(TasksRepository(dataProvider)),
            child: BacklogScreen(),
          );
        },
      },
    );
  }
}
