import 'package:backlogs/blocs/items_bloc.dart';
import 'package:backlogs/repositories/fake_items_repository.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/screens/backlog/backlog.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemsBloc(FakeItemsRepository()),
      child: MaterialApp(
        title: 'Backlogs Application',
        initialRoute: ApplicationRoutes.backlog.value,
        routes: {
          ApplicationRoutes.backlog.value: (context) => BacklogScreen(),
        },
      ),
    );
  }
}
