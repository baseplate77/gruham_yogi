import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// dark theme
// new
const Color primaryColor = Color(0xFFFF7E1D);
const Color primaryVarientColor = Color(0xFFEC6560);
const Color secondartDarkVarientColor = Color(0xFF4B4C4D);

const Color secondaryDarkColor = Color(0xFF939EB4);

const bgDarkColor = Color(0xFF151B27);
const onBgDarkColor = Color(0xFF131720);
const bottomBarDarkColor = Color(0xFF393E46);

const onPrimaryDarkColor = Color(0xFF4B4C4D);
const onSecondaryDarkColor = Colors.white;

const primaryDarkTextColor = Colors.black;

// new
const secondaryDarkTextColor = Color(0xFF4B4C4D);

const errorDarkColor = Color(0xFFC85C5C);

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      fontFamily: 'Apercu',

      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.white,
      //SPLASH COLOR
      bottomAppBarColor: bottomBarDarkColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,

      colorScheme: const ColorScheme.light().copyWith(
        primary: primaryColor,
        primaryVariant: primaryVarientColor,
        secondaryVariant: secondartDarkVarientColor,
      ),

      //Typography
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 40.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: -1.5,
          color: secondaryDarkTextColor,
        ),
        headline2: TextStyle(
          fontSize: 32.sp,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
          color: primaryDarkTextColor,
        ),
        headline3: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w700,
          color: primaryDarkTextColor,
        ),
        headline4: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
          color: primaryDarkTextColor,
        ),
        headline5: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: primaryDarkTextColor,
        ),
        headline6: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: primaryDarkTextColor,
        ),
        subtitle1: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: primaryDarkTextColor,
        ),
        subtitle2: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.1,
          color: secondaryDarkTextColor,
        ),
        bodyText1: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          color: primaryDarkTextColor,
        ),
        bodyText2: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.25,
          color: secondaryDarkTextColor,
        ),
        button: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
          color: primaryDarkTextColor,
        ),
        caption: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: primaryDarkTextColor,
        ),
        overline: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          color: primaryDarkTextColor,
        ),
      ),
    );
  }

  // static ThemeData light() {
  //   return ThemeData(
  //     fontFamily: 'Montserrat',

  //     //PINK COLOR
  //     // primaryColor: Color(0xffFF4E6A),
  //     primaryColor: Color(0xffFDB308),
  //     //SPLASH COLOR
  //     splashColor: const Color(0xffD09202),

  //     visualDensity: VisualDensity.adaptivePlatformDensity,

  //     colorScheme: const ColorScheme(
  //       primary: Color(0xffE49F02),
  //       secondary: Color(0xffFF4E6A),
  //       background: Colors.white10,
  //       brightness: Brightness.light,
  //       error: Colors.red,
  //       onBackground: Colors.black,
  //       onError: Colors.red,
  //       onPrimary: onPrimaryDarkColor,
  //       onSecondary: Colors.white,
  //       onSurface: Colors.black,
  //       primaryVariant: Color(0xffFDB308),
  //       secondaryVariant: Color(0xffFF4E6A),
  //       surface: Colors.black12,
  //     ),

  //     //Typography
  //     textTheme: TextTheme(
  //       headline2: TextStyle(
  //         fontWeight: FontWeight.w900,
  //         fontSize: 36,
  //         color: Colors.black,
  //       ),
  //       headline5: TextStyle(
  //         fontWeight: FontWeight.w900,
  //         fontSize: 22,
  //         color: Colors.black,
  //       ),
  //       headline6: TextStyle(
  //         fontWeight: FontWeight.w900,
  //         fontSize: 16,
  //         color: Colors.black,
  //       ),
  //       button: TextStyle(
  //         fontWeight: FontWeight.w800,
  //         fontSize: 16,
  //         color: Colors.white,
  //       ),
  //       // bodyText1: TextStyle(
  //       //     // fontSize: rf(14),
  //       //     ),

  //       bodyText2: TextStyle(
  //         fontWeight: FontWeight.w800,
  //         fontSize: 14,
  //       ),
  //     ),
  //   );
  // }
}
