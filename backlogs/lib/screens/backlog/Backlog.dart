import 'package:backlogs/blocs/items_bloc.dart';
import 'package:backlogs/blocs/items_event.dart';
import 'package:backlogs/blocs/items_state.dart';
import 'package:backlogs/screens/backlog/widgets/task.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/utilities/screen_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:backlogs/extensions/ui_extension.dart';

class BacklogScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BacklogScreenState();
}

class _BacklogScreenState extends State<BacklogScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ItemsBloc>(context).add(ItemsGetAll(backlogId: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ItemsBloc, ItemsState>(
        builder: (context, state) {
          if (state is ItemsReceived) {
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
                          holdedItem: state.items[index],
                          onCheckboxChanged: null,
                        ).embedInCard();
                      },
                      childCount: state.items.length,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
    // setState(() {
    //   _items.add(Item(
    //     id: 0,
    //     description: text,
    //   ));
    // });
  }
}
