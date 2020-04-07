import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/utilities/constants.dart';
import 'package:flutter/material.dart';

class AddEditBacklogScreen extends StatefulWidget {
  final Function(Backlog backlog) createAndAddBacklog;

  const AddEditBacklogScreen({@required this.createAndAddBacklog});

  @override
  State<StatefulWidget> createState() => AddEditBacklogScreenState();
}

class AddEditBacklogScreenState extends State<AddEditBacklogScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
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

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = Constants.backlogCreationHint;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('New backlog'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: controller,
                    maxLines: 1,
                    style: TextStyle(fontSize: 22.0),
                    textAlign: TextAlign.center,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                    ),
                  ),
                  Divider(),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[Icon(Icons.adb), Text('Pick icon')],
                    ),
                    onTap: null,
                  ),
                ],
              )),
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: FlatButton(
              color: ColorsLibrary.accentColor0,
              textColor: Colors.white,
              disabledColor: ColorsLibrary.accentColor0Disabled,
              disabledTextColor: Colors.white54,
              child: Text(
                'Create backlog',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onPressed: isEnabled ? _onCreatePressed : null,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void _onCreatePressed() {
    var backlog = Backlog(
      title: controller.text,
      color: Colors.red,
      icon: Icons.cloud_done,
    );
    widget.createAndAddBacklog(backlog);
    Navigator.pop(context);
  }
}
