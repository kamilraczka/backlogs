import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:backlogs/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BacklogDetailsScreen extends StatefulWidget {
  final int backlogId;

  const BacklogDetailsScreen({@required this.backlogId})
      : assert(backlogId != null);

  @override
  State<StatefulWidget> createState() => _BacklogDetailsScreenState();
}

class _BacklogDetailsScreenState extends State<BacklogDetailsScreen> {
  bool shouldRefreshOnPop = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BacklogBloc>(context).add(BacklogFetched(widget.backlogId));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, shouldRefreshOnPop);
        return true;
      },
      child: Scaffold(
        body: BlocBuilder<BacklogBloc, BacklogState>(
          builder: (context, state) {
            if (state is BacklogLoadSuccess) {
              return _buildList(state.backlogs.first);
            } else if (state is BacklogLoadInProgress) {
              return _buildLoading();
            } else {
              return _buildError();
            }
          },
        ),
        floatingActionButton: _buildFab(),
      ),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      onPressed: _goToAddEditTaskScreen,
      backgroundColor: ColorsLibrary.accentColor0,
      child: Icon(
        Icons.add,
      ),
    );
  }

  Widget _buildError() {
    return ErrorInformation();
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  CustomScrollView _buildList(Backlog backlog) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 196.0,
          brightness: Brightness.dark,
          backgroundColor: ColorsLibrary.idToColorConverter(widget.backlogId),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  backlog.iconData,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  '${backlog.title}',
                  style: TextStyle(fontSize: 22.0),
                ),
                Text(
                  '${backlog.tasks.length} tasks',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TaskRow(
                    task: backlog.tasks[index],
                    onTextTap: _goToAddEditTaskScreen,
                    onCheckboxChanged: () {
                      _toggleCheckbox(backlog, backlog.tasks[index]);
                    });
              },
              childCount: backlog.tasks.length,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleCheckbox(Backlog backlog, Task task) {
    backlog.tasks = backlog.tasks.map(
      (element) {
        if (element.id == task.id) {
          final newVal = !element.isArchived;
          print(newVal);
          element.isArchived = !element.isArchived;
          return element;
        } else
          return element;
      },
    ).toList();
    BlocProvider.of<BacklogBloc>(context).add(BacklogEdited(backlog, false));
    BlocProvider.of<BacklogBloc>(context).add(BacklogFetched(widget.backlogId));
  }

  void _goToAddEditTaskScreen({Task task}) async {
    final shouldRefresh = await Navigator.pushNamed(
      context,
      ApplicationRoutes.addEditTask,
      arguments: ScreenArguments(
        mainArg: widget.backlogId,
        additionalArg: task,
      ),
    );

    shouldRefreshOnPop = shouldRefresh;
    if (shouldRefresh != null && shouldRefresh) {
      BlocProvider.of<BacklogBloc>(context)
          .add(BacklogFetched(widget.backlogId));
    }
  }
}
