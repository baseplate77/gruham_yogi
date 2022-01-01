import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/sliver_header.dart';
import 'widgets/sticky_button.dart';
import 'widgets/yoga_pose_list.dart';

class PoseListScreen extends StatelessWidget {
  const PoseListScreen({
    Key? key,
    required this.bgImagePath,
    required this.levelName,
    required this.duration,
  }) : super(key: key);
  final String bgImagePath;
  final String levelName;
  final String duration;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          cacheExtent: 500,
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomSliverHeader(
                bgImagePath: bgImagePath,
                levelName: levelName,
                duration: duration),

            // YOGA POSE LIST
            const YogaPoseList(),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 100.h,
              ),
            )
          ],
        ),
        const Positioned.fill(
            top: null,
            // bottom: 20,
            child: StickyButton())
      ],
    ));
  }
}
