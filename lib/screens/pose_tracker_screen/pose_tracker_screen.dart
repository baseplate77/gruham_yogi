import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'widgets/camera_view.dart';
import 'painter/pose_painter.dart';

class PoseTrackerScreen extends StatefulWidget {
  const PoseTrackerScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PoseTrackerScreenState();
}

class _PoseTrackerScreenState extends State<PoseTrackerScreen> {
  PoseDetector poseDetector = GoogleMlKit.vision.poseDetector();
  bool isBusy = false;
  CustomPaint? customPaint;

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
      onImage: (inputImage) {
        processImage(inputImage);
      },
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (isBusy) return;
    isBusy = true;

    final DateTime t1 = DateTime.now();

    final poses = await poseDetector.processImage(inputImage);
    final DateTime t2 = DateTime.now();
    debugPrint(
        'Found ${poses.length} poses With latent : ${t2.difference(t1).inMilliseconds} mms');
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      final painter = PosePainter(poses, inputImage.inputImageData!.size,
          inputImage.inputImageData!.imageRotation);
      customPaint = CustomPaint(painter: painter);
    } else {
      customPaint = null;
    }
    isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
