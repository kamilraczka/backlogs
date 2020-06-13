import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
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
