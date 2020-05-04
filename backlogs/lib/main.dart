import 'package:backlogs/data/e_data.dart';
import 'package:backlogs/screens/e_screens.dart';
import 'package:backlogs/extensions/e_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/e_blocs.dart';
import 'models/e_models.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backlogsDao = BacklogsDao();
    final repository = BacklogsRepository(backlogsDao);
    BlocSupervisor.delegate = ApplicationBlocDelegate();

    return MaterialApp(
      title: 'Backlogs Application',
      initialRoute: ApplicationRoutes.backlogs.value,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == ApplicationRoutes.backlogDetails.value) {
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
