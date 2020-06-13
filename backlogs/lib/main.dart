import 'package:backlogs/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'utils/di/injection_container.dart' as di;
import 'blocs/blocs.dart';

void main() {
  di.init();
  BlocSupervisor.delegate = di.sl<ApplicationBlocDelegate>();
  runApp(Application());
}
