import 'package:backlogs/models/backlog.dart';

abstract class BacklogState {
  const BacklogState();
}

class BacklogLoadingList extends BacklogState {
  const BacklogLoadingList();
}

class BacklogReceivedAll extends BacklogState {
  final List<Backlog> backlogs;

  const BacklogReceivedAll(this.backlogs);
}
