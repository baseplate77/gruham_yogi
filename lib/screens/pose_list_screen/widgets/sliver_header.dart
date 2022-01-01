import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

import '../../../core/utils/ui_constant.dart';
import 'persistent_header_delagate_builder.dart';

class CustomSliverHeader extends StatelessWidget {
  const CustomSliverHeader({
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
    return SliverPersistentHeader(
      pinned: true,
      delegate: PersistentHeaderDealegateBuilder(
        maxExtent: 0.5.sh,
        minExtent: 180,
        builder: (percent) {
          final double topPercent = ((1 - (percent * 2))).clamp(0, 1);

          return Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: space2x),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(space3x),
                      bottomRight: Radius.circular(space3x)),
                  image: DecorationImage(
                    image: AssetImage(
                      bgImagePath,
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black
                            .withOpacity(lerpDouble(0.25, 0.1, topPercent)!),
                        BlendMode.darken),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.07.sh),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                            width: 32.w,
                            height: 32.w,
                            child: Icon(
                              Iconsax.arrow_left_2,
                              color: Colors.white,
                              size: 32.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // LEVEL NAME
              Positioned(
                  top: lerpDouble(0.068.sh, 0.2.sh, topPercent)!,
                  left: lerpDouble(60, 24, topPercent)?.w,
                  child: Text(
                    levelName,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontSize: lerpDouble(24, 40, topPercent)),
                  )),

              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: space2x, right: space2x, top: space3x),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(space3x),
                        topRight: Radius.circular(space3x)),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Time",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Text(
                        duration,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
