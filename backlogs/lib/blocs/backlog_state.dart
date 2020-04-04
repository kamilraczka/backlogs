part of 'backlog_bloc.dart';

@immutable
abstract class BacklogState {
  const BacklogState();
}

class BacklogLoadInProgress extends BacklogState {
  const BacklogLoadInProgress();
}

class BacklogLoadSuccess extends BacklogState {
  final List<Backlog> backlogs;

  const BacklogLoadSuccess(this.backlogs);
}
