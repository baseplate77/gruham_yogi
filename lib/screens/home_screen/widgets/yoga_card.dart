import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/ui_constant.dart';

class YogaCard extends StatelessWidget {
  const YogaCard({
    Key? key,
    required this.bgImagePath,
    required this.levelName,
    required this.asanaCount,
    required this.duration,
  }) : super(key: key);
  final String bgImagePath;
  final String levelName;
  final int asanaCount;
  final String duration;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(space2x),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(space2x),
          image: DecorationImage(
            image: AssetImage(bgImagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 5),
                color: Colors.black.withOpacity(0.15),
                blurRadius: 5,
                spreadRadius: 0)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            levelName,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: Colors.white,
                ),
          ),
          SizedBox(
            height: space2x.h,
          ),
          Text(
            "$asanaCount+ asana",
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white,
                ),
          ),
          SizedBox(
            height: space1x.h * 8,
          ),
          Container(
            padding: const EdgeInsets.all(space1x),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(space2x)),
            child: Text(
              duration,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          )
        ],
      ),
    );
  }
}
