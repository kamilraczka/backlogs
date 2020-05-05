import 'package:backlogs/utils/utils.dart';

import 'package:flutter/material.dart';

class AddEditTaskScreen extends StatelessWidget {
  AddEditTaskScreen({@required this.createTaskAction});

  final controller = TextEditingController();
  final Function(String description) createTaskAction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XD'),
      ),
      body: SizedBox(
        height: 256.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'New task',
                      style: TextStyle(
                        fontSize: 22.0,
                      ),
                    ),
                    margin: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'What are you planning?',
                      border: InputBorder.none,
                    ),
                    controller: controller,
                    maxLines: 3,
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Icon(Icons.timer),
                      Text('May 29, 14:00'),
                    ],
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
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                child: Text(
                  'Create task',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                onPressed: () {
                  createTaskAction(controller.text);
                  controller.clear();
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
