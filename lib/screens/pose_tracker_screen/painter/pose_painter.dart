import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../../../core/utils/coordinates_translator.dart';

class PosePainter extends CustomPainter {
  PosePainter(
    this.poses,
    this.absoluteImageSize,
    this.rotation,
    this.wrongPose,
  );

  final List<Pose> poses;
  final Size absoluteImageSize;
  final InputImageRotation rotation;
  final List<int> wrongPose;

  final double drawCircleThreshold = 0.45;

  final double drawLineThreshold = 0.45;

  final double strokeWidth = 4.0;
  final Color baseColor = Colors.white;
  final Color wrongColor = Colors.redAccent;

  @override
  void paint(Canvas canvas, Size size) {
    final spinalCordPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;

    final leftLegPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;

    final rightLegPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;
    final neckPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;

    final leftShouldlerHipPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;
    final rightShoulderHipPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;
    final leftArmPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;
    final rightArmPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;

    final hipPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;

    final shoulderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = baseColor;

    for (var pose in poses) {
      // pose.landmarks.forEach((_, landmark) {
      //   if (landmark.likelihood > drawCircleThreshold) {
      //     canvas.drawCircle(
      //         Offset(
      //           translateX(landmark.x, rotation, size, absoluteImageSize),
      //           translateY(landmark.y, rotation, size, absoluteImageSize),
      //         ),
      //         1,
      //         paint);
      //   }
      // });

      void paintLine(
          PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
        PoseLandmark joint1 = pose.landmarks[type1]!;
        PoseLandmark joint2 = pose.landmarks[type2]!;
        // Draw only if both joint are above threshold
        if (joint1.likelihood > drawLineThreshold &&
            joint2.likelihood > drawLineThreshold) {
          canvas.drawLine(
              Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
                  translateY(joint1.y, rotation, size, absoluteImageSize)),
              Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
                  translateY(joint2.y, rotation, size, absoluteImageSize)),
              paintType);
        }
      }

      drawLineFromMidPoint(PoseLandmarkType type1, PoseLandmarkType type2,
          PoseLandmarkType type3, PoseLandmarkType type4, Paint paintType) {
        PoseLandmark joint1 = pose.landmarks[type1]!;
        PoseLandmark joint2 = pose.landmarks[type2]!;
        PoseLandmark joint3 = pose.landmarks[type3]!;
        PoseLandmark joint4 = pose.landmarks[type4]!;
        if (joint1.likelihood > drawLineThreshold &&
            joint2.likelihood > drawLineThreshold &&
            joint3.likelihood > drawLineThreshold &&
            joint4.likelihood > drawLineThreshold) {
          canvas.drawLine(
              Offset(
                  translateX((joint1.x + joint2.x) / 2, rotation, size,
                      absoluteImageSize),
                  translateY((joint1.y + joint2.y) / 2, rotation, size,
                      absoluteImageSize)),
              Offset(
                  translateX((joint4.x + joint3.x) / 2, rotation, size,
                      absoluteImageSize),
                  translateY((joint3.y + joint4.y) / 2, rotation, size,
                      absoluteImageSize)),
              paintType);
        }
      }

      //Draw arms
      paintLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow,
          leftArmPaint);
      paintLine(
          PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftArmPaint);

      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
          rightArmPaint);
      paintLine(PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist,
          rightArmPaint);

      //Draw Body
      paintLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.rightShoulder,
          shoulderPaint);

      paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.rightHip, hipPaint);

      paintLine(PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip,
          leftShouldlerHipPaint);
      paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
          rightShoulderHipPaint);
      // drawLineFromMidPoint(
      //     PoseLandmarkType.leftShoulder,
      //     PoseLandmarkType.rightShoulder,
      //     PoseLandmarkType.leftHip,
      //     PoseLandmarkType.rightHip,
      //     spinalCordPaint);

      // // head
      drawLineFromMidPoint(
          PoseLandmarkType.leftShoulder,
          PoseLandmarkType.rightShoulder,
          PoseLandmarkType.leftMouth,
          PoseLandmarkType.rightMouth,
          spinalCordPaint);

      //Draw legs
      // leftLegPaint.color = wrongColor;
      paintLine(
          PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftLegPaint);
      paintLine(
          PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftLegPaint);

      paintLine(
          PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightLegPaint);
      paintLine(PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle,
          rightLegPaint);
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.absoluteImageSize != absoluteImageSize ||
        oldDelegate.poses != poses;
  }
}

// import 'package:flutter/material.dart';
// import '../../../core/utils/coordinates_translator.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

// class PosePainter extends CustomPainter {
//   PosePainter(this.poses, this.absoluteImageSize, this.rotation);

//   final List<Pose> poses;
//   final Size absoluteImageSize;
//   final InputImageRotation rotation;

//   final double drawCircleThreshold = 0.45;

//   final double drawLineThreshold = 0.45;

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 4.0
//       ..color = Colors.green;

//     final leftPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0
//       ..color = Colors.yellow;

//     final rightPaint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 3.0
//       ..color = Colors.blueAccent;

//     for (var pose in poses) {
//       pose.landmarks.forEach((_, landmark) {
//         if (landmark.likelihood > drawCircleThreshold) {
//           canvas.drawCircle(
//               Offset(
//                 translateX(landmark.x, rotation, size, absoluteImageSize),
//                 translateY(landmark.y, rotation, size, absoluteImageSize),
//               ),
//               1,
//               paint);
//         }
//       });

//       void paintLine(
//           PoseLandmarkType type1, PoseLandmarkType type2, Paint paintType) {
//         PoseLandmark joint1 = pose.landmarks[type1]!;
//         PoseLandmark joint2 = pose.landmarks[type2]!;
//         // Draw only if both joint are above threshold
//         if (joint1.likelihood > drawLineThreshold &&
//             joint2.likelihood > drawLineThreshold) {
//           canvas.drawLine(
//               Offset(translateX(joint1.x, rotation, size, absoluteImageSize),
//                   translateY(joint1.y, rotation, size, absoluteImageSize)),
//               Offset(translateX(joint2.x, rotation, size, absoluteImageSize),
//                   translateY(joint2.y, rotation, size, absoluteImageSize)),
//               paintType);
//         }
//       }

//       //Draw arms
//       paintLine(
//           PoseLandmarkType.leftShoulder, PoseLandmarkType.leftElbow, leftPaint);
//       paintLine(
//           PoseLandmarkType.leftElbow, PoseLandmarkType.leftWrist, leftPaint);
//       paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightElbow,
//           rightPaint);
//       paintLine(
//           PoseLandmarkType.rightElbow, PoseLandmarkType.rightWrist, rightPaint);

//       //Draw Body
//       paintLine(
//           PoseLandmarkType.leftShoulder, PoseLandmarkType.leftHip, leftPaint);
//       paintLine(PoseLandmarkType.rightShoulder, PoseLandmarkType.rightHip,
//           rightPaint);

//       //Draw legs
//       paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
//       paintLine(
//           PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);

//       paintLine(
//           PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
//       paintLine(
//           PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant PosePainter oldDelegate) {
//     return oldDelegate.absoluteImageSize != absoluteImageSize ||
//         oldDelegate.poses != poses;
//   }
// }
