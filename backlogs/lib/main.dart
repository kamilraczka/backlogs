import 'package:backlogs/data/data.dart';
import 'package:backlogs/screens/screens.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'injection_container.dart' as di;
import 'models/models.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = TransitionBlocDelegate();

    return MaterialApp(
      title: 'Backlogs Application',
      initialRoute: ApplicationRoutes.backlogs,
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == ApplicationRoutes.backlogDetails) {
          final Backlog backlog = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => di.sl<TaskBloc>(),
              child: BacklogDetailsScreen(parentBacklog: backlog),
            ),
          );
        }
      },
      routes: {
        ApplicationRoutes.backlogs: (context) {
          return BlocProvider(
            create: (context) => di.sl<BacklogBloc>()..add(BacklogLoadedAll()),
            child: BacklogsScreen(),
          );
        },
      },
    );
  }
}
