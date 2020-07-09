import 'package:backlogs/blocs/blocs.dart';
import 'package:backlogs/models/models.dart';
import 'package:backlogs/widgets/widgets.dart';
import 'package:backlogs/utils/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BacklogsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BacklogsScreenState();
}

class BacklogsScreenState extends State<BacklogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
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
      ),
      floatingActionButton: _buildFab(),
    );
  }

  FloatingActionButton _buildFab() {
    return FloatingActionButton(
      backgroundColor: ColorsLibrary.accentColor0,
      child: Icon(Icons.add),
      onPressed: () {
        _showAddEditBacklogBottomSheet();
      },
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
                  margin: EdgeInsets.only(left: 32.0),
                  child: Text(
                    Constants.homeHeader,
                    style: TextStyles.homeHeader,
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
                    _goToBacklogDetails(backlogs[index].id);
                  },
                  onLongPress: () {
                    _showAddEditBacklogBottomSheet(backlog: backlogs[index]);
                  },
                  child: Tile(
                    backlog: backlogs[index],
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

  void _goToBacklogDetails(int backlogId) async {
    final shouldRefresh = await Navigator.pushNamed(
      context,
      ApplicationRoutes.backlogDetails,
      arguments: ScreenArguments(mainArg: backlogId),
    );
    if (shouldRefresh != null && shouldRefresh) {
      BlocProvider.of<BacklogBloc>(context).add(BacklogListFetched());
    }
  }

  void _showAddEditBacklogBottomSheet({Backlog backlog}) {
    showModalBottomSheet(
      builder: (context) {
        return AddEditBacklogBottomSheet(
          finishAction: backlog != null ? _editBacklog : _createBacklog,
          deleteAction: _deleteBacklog,
          editingBacklog: backlog,
        );
      },
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
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
