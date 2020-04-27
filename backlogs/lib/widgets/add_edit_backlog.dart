import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';

class AddEditBacklog extends StatefulWidget {
  final Function(Backlog backlog) finishAction;
  final Function(int backlogId) deleteAction;
  final Backlog editingBacklog;
  bool get isEditing => editingBacklog != null;

  const AddEditBacklog(
      {@required this.finishAction, this.editingBacklog, this.deleteAction});

  @override
  State<StatefulWidget> createState() => AddEditBacklogState();
}

class AddEditBacklogState extends State<AddEditBacklog> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String hintText = Constants.backlogCreationHint;
  bool isEnabled = false;
  IconData pickedIconData;

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

    controller.text = widget.editingBacklog?.title;
    pickedIconData =
        widget.editingBacklog?.iconData ?? Constants.defaultIconData;
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  widget.isEditing ? _showDeleteIcon() : _showEmptySpace(),
                  Text(
                    widget.isEditing ? 'Edit backlog' : 'New backlog',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorsLibrary.textColorBold,
                      fontSize: 20.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      child: Icon(
                        Icons.clear,
                        color: ColorsLibrary.textColorBold,
                        size: 24.0,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              Divider(),
              TextField(
                controller: controller,
                maxLines: 1,
                style: TextStyle(fontSize: 24.0),
                textAlign: TextAlign.center,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(color: ColorsLibrary.textColorLight),
                  border: InputBorder.none,
                ),
              ),
              Divider(),
              GestureDetector(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        pickedIconData,
                        color: ColorsLibrary.accentColor0,
                        size: 28.0,
                      ),
                    ),
                    Text(
                      'Pick icon',
                      style: TextStyle(
                        color: ColorsLibrary.textColorBold,
                        fontSize: 18.0,
                      ),
                    )
                  ],
                ),
                onTap: _pickIcon,
              ),
              SafeArea(
                child: SizedBox(
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
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: isEnabled ? _finishWidgetAction : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _finishWidgetAction() {
    if (widget.isEditing) {
      widget.editingBacklog.title = controller.text;
      widget.editingBacklog.iconData = pickedIconData;
      widget.finishAction(widget.editingBacklog);
    } else {
      var backlog = Backlog(
        title: controller.text,
        iconData: pickedIconData,
      );
      widget.finishAction(backlog);
    }
    Navigator.pop(context);
  }

  Widget _showDeleteIcon() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          child: Icon(
            Icons.delete,
            color: ColorsLibrary.textColorBold,
            size: 24.0,
          ),
          onTap: () {
            widget.deleteAction(widget.editingBacklog.id);
            Navigator.pop(context);
          },
        ),
      );

  Widget _showEmptySpace() => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 24,
        ),
      );

  void _pickIcon() async {
    IconData iconData = await FlutterIconPicker.showIconPicker(
      context,
      iconPickerShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
    pickedIconData = iconData != null ? iconData : Constants.defaultIconData;
    setState(() {});
  }
}
