import 'package:bloc/bloc.dart';

class ApplicationBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('Event { $event }');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('Error { $error }');
    super.onError(cubit, error, stackTrace);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    print(change);
    super.onChange(cubit, change);
  }
}
