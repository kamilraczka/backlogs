import 'package:backlogs/blocs/e_blocs.dart';
import 'package:backlogs/models/e_models.dart';
import 'package:backlogs/screens/e_screens.dart';
import 'package:backlogs/utils/e_utils.dart';
import 'package:backlogs/widgets/e_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BacklogDetailsScreen extends StatefulWidget {
  final Backlog parentBacklog;

  const BacklogDetailsScreen({@required this.parentBacklog})
      : assert(parentBacklog != null);

  @override
  State<StatefulWidget> createState() => _BacklogDetailsScreenState();
}

class _BacklogDetailsScreenState extends State<BacklogDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskBloc>(context)
        .add(TaskLoadedAll(backlogId: widget.parentBacklog.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadSuccess) {
            return _buildList(state.tasks);
          } else {
            return _buildLoading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddEditTaskScreen,
        backgroundColor: ColorsLibrary.accentColor0,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  CustomScrollView _buildList(List<Task> tasks) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 196.0,
          brightness: Brightness.dark,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  widget.parentBacklog.iconData,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  '${widget.parentBacklog.title}',
                  style: TextStyle(fontSize: 22.0),
                ),
                Text(
                  '${tasks.length} tasks',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor:
              ColorsLibrary.idToColorConverter(widget.parentBacklog.id),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    _goToAddEditTaskScreen(task: tasks[index]);
                  },
                  child: BacklogRow(
                    task: tasks[index],
                    onCheckboxChanged: null,
                  ),
                );
              },
              childCount: tasks.length,
            ),
          ),
        ),
      ],
    );
  }

  void _goToAddEditTaskScreen({Task task}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddEditTaskScreen(
            finishAction: task != null ? null : _createTask,
            deleteAction: null,
            editingTask: task,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _createTask(String text) {
    final task = Task(backlogId: widget.parentBacklog.id, description: text);
    BlocProvider.of<TaskBloc>(context).add(TaskAdded(task));
  }
}
