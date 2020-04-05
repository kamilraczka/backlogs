import 'package:backlogs/blocs/task_bloc.dart';
import 'package:backlogs/models/task.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/widgets/backlog_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'creation_edit.dart';

class BacklogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  int _backlogId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _backlogId = ModalRoute.of(context).settings.arguments;
    BlocProvider.of<TaskBloc>(context)
        .add(TaskLoadedAll(backlogId: _backlogId));
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
        onPressed: _onFabPressed,
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
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.event_note,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  'All',
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
          backgroundColor: ColorsLibrary.accentColor0,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BacklogRow(
                  task: tasks[index],
                  onCheckboxChanged: null,
                );
              },
              childCount: tasks.length,
            ),
          ),
        ),
      ],
    );
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreationEditScreen(
            onCreatePressed: _createTask,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _createTask(String text) {
    final task = Task(id: 0, backlogId: _backlogId, description: text);
    BlocProvider.of<TaskBloc>(context).add(TaskAdded(task));
  }
}
