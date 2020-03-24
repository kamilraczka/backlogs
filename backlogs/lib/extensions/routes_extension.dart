import '../routes.dart';

extension RoutesExtension on ApplicationRoutes {
  String get value => _value(this);

  static String _value(ApplicationRoutes val) {
    return val.toString();
  }
}
