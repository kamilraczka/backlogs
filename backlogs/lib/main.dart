import 'package:backlogs/repositories/data_repository.dart';
import 'package:backlogs/repositories/data_providers/data_provider.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:backlogs/screens/backlog_details.dart';
import 'package:backlogs/screens/backlogs.dart';
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
    final repository = DataRepository(dataProvider);
    BlocSupervisor.delegate = TransitionBlocDelegate();

    return MaterialApp(
      title: 'Backlogs Application',
      initialRoute: ApplicationRoutes.backlogs.value,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == ApplicationRoutes.backlogDetails.value) {
          final String backlogId = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => TaskBloc(repository),
              child: BacklogDetailsScreen(parentBacklogId: backlogId),
            ),
          );
        }
      },
      routes: {
        ApplicationRoutes.backlogs.value: (context) {
          return BlocProvider(
            create: (context) =>
                BacklogBloc(repository)..add(BacklogLoadedAll()),
            child: BacklogsScreen(),
          );
        },
      },
    );
  }
}
