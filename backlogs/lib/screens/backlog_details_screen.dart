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
              return _buildView(state.backlogs.first);
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

  Widget _buildView(Backlog backlog) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppBar(
            elevation: 0.0,
            centerTitle: false,
            backgroundColor: ColorsLibrary.idToColorConverter(backlog.id),
          ),
          Container(
            color: ColorsLibrary.idToColorConverter(backlog.id),
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 16.0, right: 16.0, left: 32.0),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  backlog.iconData,
                  size: 36.0,
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
                  '${backlog.tasks.where((element) => !element.isArchived).length}' +
                      Constants.customAppBarSubHeader,
                  style: TextStyles.customAppBarSubheader,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: ColorsLibrary.idToColorConverter(backlog.id),
              child: Container(
                child: _buildList(backlog.tasks),
                decoration: BoxDecoration(
                  color: ColorsLibrary.backgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<Task> tasks) => ListView.builder(
        itemCount: tasks.length,
        padding: const EdgeInsets.only(bottom: 80.0, top: 8.0),
        itemBuilder: (context, index) {
          return TaskRow(
            task: tasks[index],
            onTextTap: _goToAddEditTaskScreen,
            onCheckboxChanged: () {
              _toggleCheckbox(tasks[index].id, tasks[index].backlogId);
            },
          );
        },
      );

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
