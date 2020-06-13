import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditTaskScreen extends StatefulWidget {
  final int parentBacklogId;
  final Task task;
  bool get isEditing => task != null;

  AddEditTaskScreen({@required this.parentBacklogId, this.task})
      : assert(parentBacklogId != null);

  @override
  State<StatefulWidget> createState() => AddEditTaskScreenState();
}

class AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final TextEditingController controller = TextEditingController();
  String hintText = Constants.backlogCreationHint;
  bool canInvokeOnFinish = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.text.isEmpty) {
        canInvokeOnFinish = false;
      } else {
        canInvokeOnFinish = true;
      }
      setState(() {});
    });

    controller.text = widget.task?.description ?? '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskSuccessfulChange) {
            Navigator.pop(context, true);
          }
        },
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoadInProgress) {
              return _buildLoading();
            } else {
              return _buildForm();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: ColorsLibrary.backgroundColor,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: ColorsLibrary.textColorBold),
      title: Text(
        widget.isEditing ? 'Edit task' : 'New Task',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsLibrary.textColorBold,
          fontSize: 20.0,
        ),
      ),
      leading: widget.isEditing
          ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: null,
            )
          : Container(),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildForm() {
    return SizedBox(
      height: 256.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: 'What are you planning?',
                    border: InputBorder.none,
                  ),
                  controller: controller,
                  autofocus: true,
                  maxLines: 3,
                ),
                Divider(),
                SizedBox(
                  height: 64.0,
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam luctus velit dui, id mattis magna tincidunt vel. Donec vitae magna et mi euismod fermentum et ac nibh.',
                    style: TextStyle(
                      color: ColorsLibrary.textColorMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: FlatButton(
              color: ColorsLibrary.accentColor0,
              textColor: Colors.white,
              disabledColor: ColorsLibrary.accentColor0Disabled,
              disabledTextColor: Colors.white54,
              child: Text(
                'Finish',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              onPressed: canInvokeOnFinish
                  ? () {
                      _onFinishAction(controller.text);
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  void _onFinishAction(String description) {
    if (widget.isEditing) {
      widget.task.description = description;
      BlocProvider.of<TaskBloc>(context).add(TaskUpdated(widget.task));
    } else
      BlocProvider.of<TaskBloc>(context).add(TaskAdded(
        Task(backlogId: widget.parentBacklogId, description: description),
      ));
  }
}
