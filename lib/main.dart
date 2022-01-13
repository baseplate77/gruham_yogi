import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gruham_yogi/screens/home_screen/home_screen.dart';

import 'core/theme/app_theme.dart';
import 'screens/login_screen/login_screen.dart';

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        builder: () {
          return DefaultTabController(
            length: 4,
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: AppTheme.light(),
              home: const HomeScreen(),
            ),
          );
        });
  }
}
