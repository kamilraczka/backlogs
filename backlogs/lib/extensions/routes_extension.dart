import 'package:backlogs/models/routes.dart';

extension RoutesExtension on ApplicationRoutes {
  String get value => _value(this);

  String _value(ApplicationRoutes val) {
    return val.toString();
  }
}
