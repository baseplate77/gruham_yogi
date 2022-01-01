import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset("assets/images/profile_avatar.svg"),
        GradientText(
          appName,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primaryVariant,
          ],
          style: Theme.of(context).textTheme.headline4,
        ),
        Icon(
          Iconsax.heart,
          size: 28.r,
          color: Theme.of(context).colorScheme.secondaryVariant,
        )
      ],
    );
  }
}
