import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';

class AddEditBacklogScreen extends StatefulWidget {
  final Function(Backlog backlog) createAndAddBacklog;

  const AddEditBacklogScreen({@required this.createAndAddBacklog});

  @override
  State<StatefulWidget> createState() => AddEditBacklogScreenState();
}

class AddEditBacklogScreenState extends State<AddEditBacklogScreen> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('New Backlog'),
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
          TextField(
            controller: controller,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'What\'s the title?',
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
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: FlatButton(
              color: ColorsLibrary.accentColor0,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              child: Text(
                'Create backlog',
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              onPressed: () {
                var backlog = Backlog(
                  title: controller.text,
                  color: Colors.red,
                  icon: Icons.cloud_done,
                );
                widget.createAndAddBacklog(backlog);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
