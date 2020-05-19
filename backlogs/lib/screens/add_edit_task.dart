import 'package:backlogs/models/models.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Function(String task) finishAction;
  final Function(int taskId) deleteAction;
  final Task editingTask;
  bool get isEditing => editingTask != null;

  const AddEditTaskScreen(
      {@required this.finishAction, this.editingTask, this.deleteAction});

  @override
  State<StatefulWidget> createState() => AddEditTaskScreenState();
}

class AddEditTaskScreenState extends State<AddEditTaskScreen> {
  final TextEditingController controller = TextEditingController();
  String hintText = Constants.backlogCreationHint;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      if (controller.text.isEmpty) {
        isEnabled = false;
      } else {
        isEnabled = true;
      }
      setState(() {});
    });

    controller.text = widget.editingTask?.description;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: SizedBox(
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
                onPressed: isEnabled ? _finishWidgetAction : null,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _finishWidgetAction() {
    widget.finishAction(null);
    Navigator.pop(context);
  }
}
