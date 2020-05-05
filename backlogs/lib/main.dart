import 'package:backlogs/data/data.dart';
import 'package:backlogs/screens/screens.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'models/models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backlogsDao = BacklogsDao();
    final repository = BacklogsRepository(backlogsDao);
    BlocSupervisor.delegate = TransitionBlocDelegate();

    return MaterialApp(
      title: 'Backlogs Application',
      initialRoute: ApplicationRoutes.backlogs,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == ApplicationRoutes.backlogDetails) {
          final Backlog backlog = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => TaskBloc(repository),
              child: BacklogDetailsScreen(parentBacklog: backlog),
            ),
          );
        }
      },
      routes: {
        ApplicationRoutes.backlogs: (context) {
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
