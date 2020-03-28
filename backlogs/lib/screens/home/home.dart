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
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Tile(
              backlog: Backlog(id: 1, icon: Icons.wallpaper, title: 'All'),
              colorId: 0,
            ),
            Tile(
              backlog: Backlog(id: 2, icon: Icons.wallpaper, title: 'All'),
              colorId: 1,
            ),
            Tile(
              backlog: Backlog(id: 2, icon: Icons.wallpaper, title: 'All'),
              colorId: 2,
            ),
            Tile(
              backlog: Backlog(id: 2, icon: Icons.wallpaper, title: 'All'),
              colorId: 3,
            ),
            Tile(
              backlog: Backlog(id: 2, icon: Icons.wallpaper, title: 'All'),
              colorId: 4,
            ),
            Tile(
              backlog: Backlog(id: 3, icon: Icons.wallpaper, title: 'All'),
              colorId: 5,
            ),
            Tile(
              backlog: Backlog(id: 4, icon: Icons.wallpaper, title: 'All'),
              colorId: 6,
            ),
            Tile(
              backlog: Backlog(id: 5, icon: Icons.wallpaper, title: 'All'),
              colorId: 7,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            ApplicationRoutes.backlog.value,
          );
        },
        backgroundColor: ColorsLibrary.accentColor0,
      ),
    );
  }
}
