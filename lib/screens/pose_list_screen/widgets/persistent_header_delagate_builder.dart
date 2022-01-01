import 'package:flutter/material.dart';

class PersistentHeaderDealegateBuilder extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;
  final Widget Function(double percent) builder;
  PersistentHeaderDealegateBuilder({
    required double maxExtent,
    required double minExtent,
    required this.builder,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return builder(shrinkOffset / _maxExtent);
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
