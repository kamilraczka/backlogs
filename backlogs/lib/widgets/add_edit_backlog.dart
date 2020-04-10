import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddEditBacklog extends StatefulWidget {
  final Function(Backlog backlog) createBacklogAction;

  const AddEditBacklog({@required this.createBacklogAction});

  @override
  State<StatefulWidget> createState() => AddEditBacklogState();
}

class AddEditBacklogState extends State<AddEditBacklog> {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AnimatedPadding(
          duration: Duration(milliseconds: 250),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 44.0),
                      child: Text(
                        'New backlog',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ColorsLibrary.textColorBold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: ColorsLibrary.textColorBold,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
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
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _createBacklog() {
    var backlog = Backlog(
      title: controller.text,
      color: Colors.red,
      iconData: pickedIcon.icon,
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
