import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';

class DestructionDialog extends StatelessWidget {
  final Function destructionAction;
  final Function resignAction;
  final String title;
  final String content;

  DestructionDialog({
    @required this.destructionAction,
    @required this.resignAction,
    @required this.title,
    this.content,
  })  : assert(destructionAction != null),
        assert(resignAction != null),
        assert(title != null);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content) ?? null,
      actions: <Widget>[
        FlatButton(
          child: Text(
            Constants.dialogRejection,
            style: TextStyle(color: ColorsLibrary.textColorBoldBlack),
          ),
          onPressed: resignAction,
        ),
        FlatButton(
          child: Text(
            Constants.dialogConfirmation,
            style: TextStyle(color: Colors.red),
          ),
          onPressed: destructionAction,
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0), bottom: Radius.circular(20.0)),
      ),
    );
  }
}
