import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:backlogs/widgets/widgets.dart';
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
      body: BlocListener<TaskCubit, TaskState>(
        listener: (context, state) {
          if (state is TaskSuccessfulChange) {
            Navigator.pop(context, true);
          }
        },
        child: BlocBuilder<TaskCubit, TaskState>(
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
      iconTheme: IconThemeData(color: ColorsLibrary.textColorBoldBlack),
      title: Text(
        widget.isEditing ? Constants.editTaskTitle : Constants.newTaskTitle,
        textAlign: TextAlign.center,
        style: TextStyles.customScaffoldHeader,
      ),
      leading: widget.isEditing
          ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _showDeleteDialog(context);
              },
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
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: Constants.newTaskDescription,
                      border: InputBorder.none,
                    ),
                    controller: controller,
                    autofocus: true,
                    maxLines: 3,
                  ),
                  Divider(),
                ],
              ),
            ),
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
              Constants.buttonFinishAction,
              style: TextStyles.buttonText,
            ),
            onPressed: canInvokeOnFinish
                ? () {
                    _onFinishAction(controller.text);
                  }
                : null,
          ),
        )
      ],
    );
  }

  void _onFinishAction(String description) {
    if (widget.isEditing) {
      widget.task.description = description;
      BlocProvider.of<TaskCubit>(context).updateTask(widget.task);
    } else
      BlocProvider.of<TaskCubit>(context).addTask(
        Task(backlogId: widget.parentBacklogId, description: description),
      );
  }

  Future _showDeleteDialog(BuildContext screenContext) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return DestructionDialog(
          title: Constants.deleteTaskTitle,
          content: Constants.deleteTaskContent,
          destructionAction: () {
            BlocProvider.of<TaskCubit>(screenContext)
                .deleteTask(widget.task.id, widget.task.backlogId);
            Navigator.pop(context);
          },
          resignAction: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
