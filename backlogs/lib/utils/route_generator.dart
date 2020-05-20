import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/injection_container.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/screens/backlogs.dart';
import 'package:backlogs/screens/screens.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
      BuildContext context, RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case ApplicationRoutes.backlogs:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      sl<BacklogBloc>()..add(BacklogLoadedAll()),
                  child: BacklogsScreen(),
                ));
      case ApplicationRoutes.backlogDetails:
        if (args is Backlog) {
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => sl<TaskBloc>(),
              child: BacklogDetailsScreen(parentBacklog: args),
            ),
          );
        }
        return throw UnimplementedError();
      case ApplicationRoutes.addEditTask:
        return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) =>
                AddEditTaskScreen(editingTask: args is Task ? args : null));
      default:
        return throw UnimplementedError();
    }
  }
}
