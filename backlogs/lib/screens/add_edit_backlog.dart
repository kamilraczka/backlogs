import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddEditBacklogScreen extends StatefulWidget {
  final Function(Backlog backlog) createBacklogAction;

  const AddEditBacklogScreen({@required this.createBacklogAction});

  @override
  State<StatefulWidget> createState() => AddEditBacklogScreenState();
}

class AddEditBacklogScreenState extends State<AddEditBacklogScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String hintText = Constants.backlogCreationHint;
  bool isEnabled = false;
  Icon pickedIcon = Constants.defaultIcon;

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
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
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
                    children: <Widget>[
                      AnimatedSwitcher(
                        duration: Duration(microseconds: 2000),
                        child: pickedIcon,
                      ),
                      Text('Pick backlog\'s icon')
                    ],
                  ),
                  onTap: _pickIcon,
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
                'Create backlog',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onPressed: isEnabled ? _createBacklog : null,
            ),
          )
        ],
      ),
    );
  }

  void _createBacklog() {
    var backlog = Backlog(
      title: controller.text,
      color: Colors.red,
      icon: Icons.cloud_done,
    );
    widget.createBacklogAction(backlog);
    Navigator.pop(context);
  }

  void _pickIcon() async {
    IconData iconData = await FlutterIconPicker.showIconPicker(context);
    pickedIcon = iconData != null ? Icon(iconData) : Constants.defaultIcon;
    setState(() {});
  }
}
