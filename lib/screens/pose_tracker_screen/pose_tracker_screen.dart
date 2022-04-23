import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:gruham_yogi/core/ml/analysis_algorithm.dart';

import '../../core/ml/classifier.dart';
import '../../core/utils/angle_calculator.dart';
import 'painter/pose_painter.dart';
import 'widgets/camera_view.dart';

class PoseTrackerScreen extends StatefulWidget {
  const PoseTrackerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PoseTrackerScreenState();
}

class _PoseTrackerScreenState extends State<PoseTrackerScreen> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector(
      poseDetectorOptions:
          PoseDetectorOptions(model: PoseDetectionModel.accurate));
  bool isBusy = false;
  CustomPaint? customPaint;

  late Classifer _classifer;
  String poseName = "";

  @override
  void initState() {
    super.initState();
    _classifer = Classifer();
  }

  @override
  void dispose() async {
    super.dispose();
    await poseDetector.close();
  }

  @override
  Widget build(BuildContext context) {
    return CameraView(
      title: 'Pose Detector',
      customPaint: customPaint,
      onImage: (inputImage) async {
        return await processImage(inputImage);
      },
    );
    // return CameraPerview(
    //   title: 'Pose Detector',
    //   customPaint: customPaint,
    //   onImage: (inputImage) {
    //     processImage(inputImage);
    //   },
    // );
  }

  Future<String> processImage(InputImage inputImage) async {
    if (isBusy) return "";
    isBusy = true;

    final DateTime t1 = DateTime.now();

    final poses = await poseDetector.processImage(inputImage);
    final DateTime t2 = DateTime.now();

    // angle calculation process
    // if (poses.isNotEmpty) {
    //   // final output = angleCalculator(poses[0].landmarks);
    //   final wrongAngle = analysisPose(poses[0].landmarks);
    //   print("TOTAL WRONG ANGLE : ${wrongAngle.length}");
    //   print("WRONG POSE ANGLE : $wrongAngle");
    //   // poseName = _classifer.classify(output);

    //   //rint("output is here : $normed_output");
    // }

    debugPrint(
        'Found ${poses.length} poses With latent : ${t2.difference(t1).inMilliseconds} mms');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null &&
        poses.isNotEmpty) {
      // logic for checking to if the joint angle comes in the standared close to standared angle
      final output = analysisPose(poses[0].landmarks);
      final wrongAngle = output[0];
      poseName = _classifer.classify(output[1] as List<double>);
      print("TOTAL WRONG ANGLE : ${wrongAngle.length}");
      print("WRONG POSE ANGLE : $wrongAngle");

      // print("image size : ${inputImage.inputImageData!.size}");

      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation, wrongAngle as List<int>);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    // await Future.delayed(const Duration(milliseconds: 100));
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
    return poseName;
  }
}
