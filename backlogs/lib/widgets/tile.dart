import 'package:backlogs/models/models.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final Backlog backlog;

  Tile({
    this.backlog,
  }) : super(key: ObjectKey(backlog));

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            backlog.iconData,
            color: ColorsLibrary.idToColorConverter(backlog.id),
            size: 40.0,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(
            backlog.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.tileHeader,
          ),
          Text(
            '${backlog.tasks.where((element) => !element.isArchived).length} Tasks',
            style: TextStyles.tileSubheader,
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
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
