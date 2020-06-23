import 'package:auto_size_text/auto_size_text.dart';
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
          backgroundColor: ColorsLibrary.idToColorConverter(backlog.id),
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
                AutoSizeText(
                  '${backlog.title}',
                  maxLines: 2,
                  style: TextStyles.customAppBarHeader,
                ),
                Text(
                  '${backlog.tasks.where((element) => !element.isArchived).length} active tasks',
                  style: TextStyles.customAppBarSubheader,
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 8.0, right: 8.0, bottom: 64.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return TaskRow(
                    task: backlog.tasks[index],
                    onTextTap: _goToAddEditTaskScreen,
                    onCheckboxChanged: () {
                      _toggleCheckbox(backlog.tasks[index].id,
                          backlog.tasks[index].backlogId);
                    });
              },
              childCount: backlog.tasks.length,
            ),
          ),
        ),
      ],
    );
  }

  void _toggleCheckbox(String taskId, int backlogId) {
    BlocProvider.of<TaskBloc>(context).add(TaskToggled(taskId, backlogId));
    shouldRefreshOnPop = true;
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
