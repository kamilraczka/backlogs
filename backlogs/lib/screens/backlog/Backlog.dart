import 'package:backlogs/blocs/items_bloc.dart';
import 'package:backlogs/blocs/items_event.dart';
import 'package:backlogs/blocs/items_state.dart';
import 'package:backlogs/models/item.dart';
import 'package:backlogs/screens/backlog/widgets/task.dart';
import 'package:backlogs/screens/creation/creation_edit.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            return _buildList(state.items);
          } else {
            return _buildLoading();
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

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  CustomScrollView _buildList(List<Item> items) {
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
                  holdedItem: items[index],
                  onCheckboxChanged: null,
                );
              },
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }

  void _onFabPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CreationEditScreen(
            onCreatePressed: _createTask,
          );
        },
        fullscreenDialog: true,
      ),
    );
  }

  void _createTask(String text) {
    final itemsBloc = BlocProvider.of<ItemsBloc>(context);
    final item = Item(id: 0, description: text);
    itemsBloc.add(ItemsAddItem(item: item));
  }
}
