part of 'backlog_bloc.dart';

@immutable
abstract class BacklogEvent {
  const BacklogEvent();
}

class BacklogLoadedAll extends BacklogEvent {
  const BacklogLoadedAll();
}

class BacklogOpened extends BacklogEvent {
  const BacklogOpened();
}

class BacklogAdded extends BacklogEvent {
  final Backlog backlog;

  const BacklogAdded(this.backlog);
}

class BacklogEdited extends BacklogEvent {
  final Backlog backlog;

  const BacklogEdited(this.backlog);
}

class BacklogDeleted extends BacklogEvent {
  final Backlog backlog;

  const BacklogDeleted(this.backlog);
}
