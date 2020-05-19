import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;
import 'blocs/blocs.dart';
import 'utils/utils.dart';

void main() {
  di.init();
  BlocSupervisor.delegate = di.sl<ApplicationBlocDelegate>();
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
