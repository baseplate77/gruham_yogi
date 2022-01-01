import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants.dart';
import '../../core/utils/ui_constant.dart';
import '../../core/widgets/app_bar.dart';
import '../../core/widgets/bottom_bar.dart';
import '../pose_list_screen/pose_list_screen.dart';
import 'widgets/yoga_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  onYogaCardTap(BuildContext context, {required int index}) {
    Navigator.push(context, PageRouteBuilder(pageBuilder: (_, animation, __) {
      return FadeTransition(
        opacity: animation,
        child: PoseListScreen(
          bgImagePath: yogaCardData[index].bgImagePath,
          levelName: yogaCardData[index].levelName,
          duration: yogaCardData[index].duration,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomBar(),
      body: ListView(
        padding: EdgeInsets.only(
            top: 60.h, left: space2x, right: space2x, bottom: 60.h),
        children: [
          const CustomAppBar(),
          SizedBox(
            height: space3x.h,
          ),
          Text(
            "Welcome to your Spiritual Arena!!",
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(
            height: space3x.h,
          ),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => onYogaCardTap(context, index: index),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: space1x * 1.5),
                  child: YogaCard(
                    bgImagePath: yogaCardData[index].bgImagePath,
                    levelName: yogaCardData[index].levelName,
                    asanaCount: yogaCardData[index].asanaCount,
                    duration: yogaCardData[index].duration,
                  ),
                ),
              );
            },
            itemCount: yogaCardData.length,
          )
        ],
      ),
    );
  }
}
