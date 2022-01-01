// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gruham_yogi/constants.dart';
import 'package:gruham_yogi/core/utils/ui_constant.dart';
import 'package:gruham_yogi/screens/home_screen/home_screen.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  signIn() {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(space2x),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(1),
          image: const DecorationImage(
            image: AssetImage("assets/images/login_screen_bg_md.jpg"),
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            GradientText(
              appName,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primaryVariant,
              ],
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: space5x.h,
            ),
            Text(
              tagLine,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Text(
              "Continue With",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              height: space2x.h,
            ),
            MaterialButton(
              padding: const EdgeInsets.all(space1x * 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(space2x)),
              color: Colors.white,
              onPressed: signIn,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/images/google_logo.svg"),
                  SizedBox(
                    width: space2x.h,
                  ),
                  Text(
                    "Sign in with Google",
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            ),
            SizedBox(
              height: space3x.h,
            ),
          ],
        ),
      ),
    );
  }
}
