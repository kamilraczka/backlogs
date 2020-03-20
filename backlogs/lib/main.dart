import 'package:backlogs/screens/backlog/backlog.dart';
import 'package:backlogs/screens/creation/creation.dart';
import 'package:backlogs/utilities/screen_arguments.dart';
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
              return CreationScreen(
                onCreatePressed: args.function,
              );
            },
            fullscreenDialog: true,
          );
        }
      },
      initialRoute: '/',
      routes: {
        '/': (context) => BacklogScreen(),
      },
    );
  }
}
