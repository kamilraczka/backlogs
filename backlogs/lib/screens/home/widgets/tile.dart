import 'package:backlogs/models/backlog.dart';
import 'package:backlogs/utilities/colors_library.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  Tile({this.backlog, this.colorId}) : super(key: ObjectKey(backlog));

  final Backlog backlog;
  final int colorId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            backlog.icon,
            color: ColorsLibrary.idToColorConverter(colorId),
            size: 40.0,
          ),
          SizedBox(
            height: 24.0,
          ),
          Text(
            backlog.title,
            style: TextStyle(
              color: ColorsLibrary.textColorBold,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '23 Tasks',
            style: TextStyle(
              color: ColorsLibrary.textColorLight,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: ColorsLibrary.backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: ColorsLibrary.shadowColors,
            blurRadius: 12.0,
            spreadRadius: 4.0,
          )
        ],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
