import 'package:backlogs/blocs/items_bloc.dart';
import 'package:backlogs/screens/backlog/widgets/task.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/utilities/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:backlogs/models/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BacklogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  @override
  Widget build(BuildContext context) {
    final ItemsBloc itemsBloc = BlocProvider.of<ItemsBloc>(context);

    return Scaffold(
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          return CustomScrollView(
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
                      return Task(
                        holdedItem: _items[index],
                        onCheckboxChanged: null,
                      );
                    },
                    childCount: _items.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        backgroundColor: ColorsLibrary.primaryColor,
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void _onFabPressed() {
    Navigator.pushNamed(
      context,
      '/creation',
      arguments: ScreenArguemnts(_createTask),
    );
  }

  void _createTask(String text) {
    setState(() {
      _items.add(Item(
        id: 0,
        description: text,
      ));
    });
  }
}
