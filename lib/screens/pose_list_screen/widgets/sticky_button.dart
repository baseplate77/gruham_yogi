import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gruham_yogi/screens/pose_tracker_screen/pose_tracker_screen.dart';

import '../../../core/utils/ui_constant.dart';

class StickyButton extends StatelessWidget {
  const StickyButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white10,
            Colors.white,
            Colors.white,
          ],
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => const PoseTrackerScreen()));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: space2x, vertical: space2x),
          width: 1.sw - 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(space5x),
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryVariant,
              ])),
          child: Text(
            "Start Partice",
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
