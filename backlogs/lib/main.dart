import 'package:backlogs/repositories/backlogs_repository.dart';
import 'package:backlogs/repositories/data_providers/data_provider.dart';
import 'package:backlogs/repositories/tasks_repository.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:backlogs/screens/backlog.dart';
import 'package:backlogs/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/backlog_bloc.dart';
import 'blocs/task_bloc.dart';
import 'blocs/transition_bloc_delegate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataProvider = DataProvider();
    BlocSupervisor.delegate = TransitionBlocDelegate();

    return BlocProvider(
      create: (context) => TaskBloc(TasksRepository(dataProvider)),
      child: MaterialApp(
        title: 'Backlogs Application',
        initialRoute: ApplicationRoutes.home.value,
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == ApplicationRoutes.backlog.value) {
            final int backlogId = settings.arguments;
            return MaterialPageRoute(
              builder: (context) => BacklogScreen(parentBacklogId: backlogId),
            );
          }
        },
        routes: {
          ApplicationRoutes.home.value: (context) {
            return BlocProvider(
              create: (context) => BacklogBloc(
                BacklogsRepository(dataProvider),
                BlocProvider.of<TaskBloc>(context),
              )..add(BacklogLoadedAll()),
              child: HomeScreen(),
            );
          },
        },
      ),
    );
  }
}
