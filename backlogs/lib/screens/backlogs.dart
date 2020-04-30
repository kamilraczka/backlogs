import 'package:backlogs/blocs/backlog_bloc.dart';
import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/widgets/add_edit_backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:backlogs/widgets/simple_sliver_persistent_header.dart';
import 'package:backlogs/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BacklogsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BacklogsScreenState();
}

class BacklogsScreenState extends State<BacklogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorsLibrary.backgroundColor,
          child: BlocBuilder<BacklogBloc, BacklogState>(
            builder: (context, state) {
              if (state is BacklogLoadSuccess) {
                return _buildScrollViewWithGrid(state.backlogs);
              } else if (state is BacklogLoadInProgress) {
                return _buildLoading();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorsLibrary.accentColor0,
        child: Icon(Icons.add),
        onPressed: () {
          _showAddEditBacklogWidget();
        },
      ),
    );
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  CustomScrollView _buildScrollViewWithGrid(List<Backlog> backlogs) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          pinned: false,
          floating: false,
          delegate: SimpleSliverPersistentHeader(
            content: PreferredSize(
              preferredSize: Size.fromHeight(96.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.only(left: 40.0),
                  child: Text(
                    'Lists',
                    style: TextStyle(
                      color: ColorsLibrary.textColorBold,
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16.0),
          sliver: SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ApplicationRoutes.backlogDetails.value,
                      arguments: backlogs[index],
                    );
                  },
                  onLongPress: () {
                    _showAddEditBacklogWidget(backlog: backlogs[index]);
                  },
                  child: Tile(
                    backlog: backlogs[index],
                    colorId: backlogs[index].id,
                  ),
                );
              },
              childCount: backlogs.length,
            ),
          ),
        ),
      ],
    );
  }

  void _showAddEditBacklogWidget({Backlog backlog}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddEditBacklog(
          finishAction: backlog != null ? _editBacklog : _createBacklog,
          deleteAction: _deleteBacklog,
          editingBacklog: backlog,
        );
      },
    );
  }

  void _createBacklog(Backlog backlog) {
    BlocProvider.of<BacklogBloc>(context).add(BacklogAdded(backlog));
  }

  void _editBacklog(Backlog backlog) {
    BlocProvider.of<BacklogBloc>(context).add(BacklogEdited(backlog));
  }

  void _deleteBacklog(int backlogId) {
    BlocProvider.of<BacklogBloc>(context).add(BacklogDeleted(backlogId));
  }
}
