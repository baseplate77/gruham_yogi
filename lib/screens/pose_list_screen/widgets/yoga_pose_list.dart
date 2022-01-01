import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gruham_yogi/constants.dart';

import '../../../core/utils/ui_constant.dart';

class YogaPoseList extends StatelessWidget {
  const YogaPoseList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            key: ValueKey(index),
            padding: const EdgeInsets.all(space2x),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(space2x),
                  child: Image.asset(
                    yogaPoseList[index].imagePath,
                    width: 70.w,
                    height: 70.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: space3x.w,
                ),
                Flexible(
                  child: Text(
                    yogaPoseList[index].asanaName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: space2x, vertical: space1x),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(space4x),
                  ),
                  child: Text(
                    "30 s",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            ),
          );
        },
        childCount: yogaPoseList.length,
      ),
    );
  }
}
