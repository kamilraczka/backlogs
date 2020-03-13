import 'package:backlogs/models/Item.dart';
import 'package:backlogs/utilities/colors.dart';
import 'package:flutter/material.dart';

class BacklogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  var items = <Item>[];
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 196.0,
            title: Text('All tasks'),
            backgroundColor: ColorsLibrary.primaryColor,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _buildTaskRow(items[index]);
                },
                childCount: items.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onFabPressed(),
        backgroundColor: ColorsLibrary.primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  Widget _buildTaskRow(Item item) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              item.description,
            ),
          ),
          Checkbox(
            value: item.isDone,
            onChanged: null,
          )
        ],
      ),
    );
  }

  void _onFabPressed() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
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
                      controller: _controller,
                      maxLines: 2,
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
                  color: ColorsLibrary.primaryColor,
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
                    _createTask(_controller.text);
                    _controller.clear();
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void _createTask(String text) {
    setState(() {
      items.add(
        Item(text, false),
      );
    });
  }
}
