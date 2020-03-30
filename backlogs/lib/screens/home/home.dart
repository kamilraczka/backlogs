import 'package:backlogs/blocs/backlog/backlog_bloc.dart';
import 'package:backlogs/blocs/backlog/backlog_state.dart';
import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/screens/home/widgets/tile.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';
import 'package:backlogs/extensions/routes_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(128.0),
        child: AppBar(
          backgroundColor: ColorsLibrary.backgroundColor,
          elevation: 0.0,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Lists',
                  style: TextStyle(
                    color: ColorsLibrary.textColorBold,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: ColorsLibrary.backgroundColor,
        child: BlocBuilder<BacklogBloc, BacklogState>(
          builder: (context, state) {
            if (state is BacklogReceivedAll) {
              return _buildGrid(state.backlogs);
            } else if (state is BacklogLoadingList) {
              return _buildLoading();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: null,
        backgroundColor: ColorsLibrary.accentColor0,
      ),
    );
  }

  Center _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  GridView _buildGrid(List<Backlog> backlogs) {
    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: backlogs.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: _onTileTap,
          child: Tile(
            backlog: backlogs[index],
            colorId: index,
          ),
        );
      },
    );
  }

  void _onTileTap() {
    Navigator.pushNamed(
      context,
      ApplicationRoutes.backlog.value,
    );
  }
}
