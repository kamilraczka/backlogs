import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/data/data.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/screens/screens.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(
      BuildContext context, RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case ApplicationRoutes.backlogs:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: (context) =>
                      sl<BacklogBloc>()..add(BacklogListFetched()),
                  child: BacklogsScreen(),
                ));
      case ApplicationRoutes.backlogDetails:
        if (args is ScreenArguments) {
          return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider<TaskBloc>(
                  create: (BuildContext context) => sl<TaskBloc>(),
                ),
                BlocProvider<BacklogBloc>(
                  create: (BuildContext context) => BacklogBloc(
                      sl<BacklogsRepository>(),
                      BlocProvider.of<TaskBloc>(context)),
                ),
              ],
              child: BacklogDetailsScreen(
                backlogId: args.mainArg as int,
              ),
            ),
          );
        }
        return throw UnimplementedError();
      case ApplicationRoutes.addEditTask:
        if (args is ScreenArguments) {
          return MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => BlocProvider(
              create: (context) => sl<TaskBloc>(),
              child: AddEditTaskScreen(
                parentBacklogId: args.mainArg as int,
                task: args.additionalArg as Task ?? null,
              ),
            ),
          );
        }
        return throw UnimplementedError();
      default:
        return throw UnimplementedError();
    }
  }
}
