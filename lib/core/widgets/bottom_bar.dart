import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Iconsax.home,
              size: 32.r,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(
              Iconsax.medal_star,
              size: 32.r,
            ),
            label: "Challenge"),
        BottomNavigationBarItem(
            icon: Icon(
              Iconsax.profile_circle,
              size: 32.r,
            ),
            label: "Profile"),
      ],
    );
  }
}
