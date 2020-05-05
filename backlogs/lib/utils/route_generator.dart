import 'package:backlogs/screens/backlogs.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case ApplicationRoutes.backlogs:
        return BlocProvider(
          create: (context) => BacklogBloc(repository)..add(BacklogLoadedAll()),
          child: BacklogsScreen(),
        );
      default:
        return throw UnimplementedError();
    }
  }
}
