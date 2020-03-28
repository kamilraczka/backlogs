import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/routes.dart';
import 'package:backlogs/screens/home/widgets/tile.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';
import 'package:backlogs/extensions/routes_extension.dart';

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
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: false,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Lists',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Tile(
            backlog: Backlog(id: 0, icon: Icons.wallpaper, title: 'All'),
          ),
          Tile(
            backlog: Backlog(id: 0, icon: Icons.wallpaper, title: 'All'),
          ),
          Tile(
            backlog: Backlog(id: 0, icon: Icons.wallpaper, title: 'All'),
          ),
          Tile(
            backlog: Backlog(id: 0, icon: Icons.wallpaper, title: 'All'),
          ),
          Tile(
            backlog: Backlog(id: 0, icon: Icons.wallpaper, title: 'All'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            ApplicationRoutes.backlog.value,
          );
        },
        backgroundColor: ColorsLibrary.primaryColor,
      ),
    );
  }
}
