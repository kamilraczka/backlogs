import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'injection_container.dart' as di;

void main() {
  di.init();
  BlocSupervisor.delegate = TransitionBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backlogs Application',
      initialRoute: ApplicationRoutes.backlogs,
      onGenerateRoute: (RouteSettings settings) {
        return RouteGenerator.generateRoute(context, settings);
      },
    );
  }
}
