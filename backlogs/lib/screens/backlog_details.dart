import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/screens/screens.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:backlogs/widgets/widgets.dart';

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
                    _goToAddEditTaskScreen(selectedTask: tasks[index]);
                  },
                  child: TaskRow(
                    task: tasks[index],
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

  void _goToAddEditTaskScreen({Task selectedTask}) async {
    final taskDescription = await Navigator.pushNamed(
      context,
      ApplicationRoutes.addEditTask,
      arguments: selectedTask,
    );
    if (taskDescription != null) {
      final task = Task(
          backlogId: widget.parentBacklog.id, description: taskDescription);
      BlocProvider.of<TaskBloc>(context).add(TaskAdded(task));
    }
  }
}
