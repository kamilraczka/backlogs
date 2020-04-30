import 'package:flutter/material.dart';

class SimpleSliverPersistentHeader extends SliverPersistentHeaderDelegate {
  final PreferredSize content;

  SimpleSliverPersistentHeader({this.content});

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      content;

  @override
  double get maxExtent => content.preferredSize.height;

  @override
  double get minExtent => content.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
