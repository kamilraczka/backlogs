import 'package:backlogs/blocs/backlog/backlog_event.dart';
import 'package:backlogs/blocs/task/task_bloc.dart';
import 'package:backlogs/repositories/fake_backlogs_repository.dart';
import 'package:backlogs/repositories/fake_tasks_repository.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:backlogs/screens/backlog/backlog.dart';
import 'package:backlogs/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/backlog/backlog_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BacklogBloc(FakeBacklogsRepository())..add(BacklogGetAll()),
      child: MaterialApp(
        title: 'Backlogs Application',
        initialRoute: ApplicationRoutes.home.value,
        routes: {
          ApplicationRoutes.home.value: (context) => HomeScreen(),
          ApplicationRoutes.backlog.value: (context) {
            return BlocProvider(
              create: (context) => TaskBloc(FakeTasksRepository()),
              child: BacklogScreen(),
            );
          },
        },
      ),
    );
  }
}
