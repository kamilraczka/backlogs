import 'package:backlogs/screens/backlog/Backlog.dart';
import 'package:backlogs/utilities/ScreenArguments.dart';
import 'package:backlogs/screens/creation/Creation.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Backlogs Application',
      onGenerateRoute: (settings) {
        if (settings.name == '/creation') {
          final ScreenArguemnts args = settings.arguments;

          return MaterialPageRoute(
            builder: (context) {
              return Creation(
                onCreatePressed: args.function,
              );
            },
            fullscreenDialog: true,
          );
        }
      },
      initialRoute: '/',
      routes: {
        '/': (context) => Backlog(),
      },
    );
  }
}
