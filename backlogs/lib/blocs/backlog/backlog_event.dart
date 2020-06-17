part of 'backlog_bloc.dart';

@immutable
abstract class BacklogEvent {
  const BacklogEvent();
}

class BacklogListFetched extends BacklogEvent {
  const BacklogListFetched();
}

class BacklogFetched extends BacklogEvent {
  final int backlogId;
  const BacklogFetched(this.backlogId);
}

class BacklogAdded extends BacklogEvent {
  final Backlog backlog;
  const BacklogAdded(this.backlog);
}

class BacklogEdited extends BacklogEvent {
  final Backlog backlog;
  final bool onMain;
  const BacklogEdited(this.backlog, [this.onMain = true]);
}

class BacklogDeleted extends BacklogEvent {
  final int backlogId;
  const BacklogDeleted(this.backlogId);
}
