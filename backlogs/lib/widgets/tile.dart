import 'dart:math';

import 'package:backlogs/models/models.dart';
import 'package:backlogs/utils/utils.dart';
import 'package:flutter/material.dart';

class Tile extends StatefulWidget {
  final Backlog backlog;
  final int colorId;

  Tile({
    this.backlog,
    this.colorId,
  }) : super(key: ObjectKey(backlog));

  @override
  State<StatefulWidget> createState() => _TileState();
}

class _TileState extends State<Tile> with SingleTickerProviderStateMixin {
  Animation<double> animationMargin;
  Animation<double> animationOpacity;
  Animation<double> animationRotate;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animationMargin =
        Tween<double>(begin: 64, end: 0).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    animationRotate =
        Tween<double>(begin: 0, end: 4 * pi).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    animationOpacity =
        Tween<double>(begin: 0, end: 1).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: animationRotate.value,
      child: Opacity(
        opacity: animationOpacity.value,
        child: Container(
          margin: EdgeInsets.all(animationMargin.value),
          padding: const EdgeInsets.all(24),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  widget.backlog.iconData,
                  color: ColorsLibrary.idToColorConverter(widget.colorId),
                  size: 40.0,
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  widget.backlog.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorsLibrary.textColorBold,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.backlog.tasks.length} Tasks',
                  style: TextStyle(
                    color: ColorsLibrary.textColorLight,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
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
        ),
      ),
    );
  }
}
