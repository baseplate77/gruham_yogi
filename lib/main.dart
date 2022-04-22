import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/ml/posenet_model.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/pose_tracker_screen/widgets/camera_preview.dart';

List<CameraDescription> cameras = [];

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }
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
              // home: const CameraPerview(),
              // home: const TempScreen(),
            ),
          );
        });
  }
}

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  State<TempScreen> createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  late PoseNetModel poseNetModel;

  @override
  void initState() {
    print("object");
    super.initState();
    poseNetModel = PoseNetModel();
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                // angleCalculator();
              },
              child: const Text("process"),
            )
          ],
        ),
      ),
    );
  }
}
