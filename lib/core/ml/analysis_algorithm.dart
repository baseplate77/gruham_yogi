import 'package:google_ml_kit/google_ml_kit.dart';

import '../utils/angle_calculator.dart';

List<double> stdWarrior2Angles = [
  100.896259,
  103.376754,
  91.557450,
  87.676649,
  176.249650,
  175.955514,
  98.749165,
  99.685148,
  31.889539,
  40.100298,
  176.008118,
  172.349166
];

// use to check
int difficultyBuffer = 25;

List<List> analysisPose(
  Map<PoseLandmarkType, PoseLandmark> landmark,
) {
  // List<List<PoseLandmarkType>> wrongPoseLandmark = [];
  List<int> wrongPoseLandmark = [];

  final poseAngles = angleCalculator(landmark);

  for (var i = 0; i < poseAngles.length; i++) {
    if (!((stdWarrior2Angles[i] + difficultyBuffer) >= poseAngles[i] &&
        poseAngles[i] >= (stdWarrior2Angles[i] - difficultyBuffer))) {
      // wrongPoseLandmark.add(jointsAngleLandmarks[i]);
      wrongPoseLandmark.add(i);
    }
  }

  return [wrongPoseLandmark, poseAngles];
}

// List<List<PoseLandmarkType>> jointsAngleLandmarks = [
//   [
//     PoseLandmarkType.leftShoulder,
//     PoseLandmarkType.leftElbow,
//     PoseLandmarkType.leftHip
//   ],
//   [
//     PoseLandmarkType.rightShoulder,
//     PoseLandmarkType.rightElbow,
//     PoseLandmarkType.rightHip
//   ],
//   [
//     PoseLandmarkType.leftShoulder,
//     PoseLandmarkType.rightShoulder,
//     PoseLandmarkType.leftHip
//   ],
//   [
//     PoseLandmarkType.rightShoulder,
//     PoseLandmarkType.leftShoulder,
//     PoseLandmarkType.rightHip
//   ],
//   [
//     PoseLandmarkType.leftElbow,
//     PoseLandmarkType.leftShoulder,
//     PoseLandmarkType.leftWrist
//   ],
//   [
//     PoseLandmarkType.leftElbow,
//     PoseLandmarkType.rightShoulder,
//     PoseLandmarkType.leftWrist
//   ],
//   [
//     PoseLandmarkType.leftHip,
//     PoseLandmarkType.rightHip,
//     PoseLandmarkType.leftShoulder
//   ],
//   [
//     PoseLandmarkType.rightHip,
//     PoseLandmarkType.leftHip,
//     PoseLandmarkType.rightShoulder
//   ],
//   [
//     PoseLandmarkType.leftHip,
//     PoseLandmarkType.leftKnee,
//     PoseLandmarkType.leftAnkle
//   ],
//   [
//     PoseLandmarkType.rightHip,
//     PoseLandmarkType.rightKnee,
//     PoseLandmarkType.rightAnkle
//   ],
//   [
//     PoseLandmarkType.leftKnee,
//     PoseLandmarkType.leftAnkle,
//     PoseLandmarkType.leftHip
//   ],
//   [
//     PoseLandmarkType.rightKnee,
//     PoseLandmarkType.rightAnkle,
//     PoseLandmarkType.rightHip
//   ],
// ];
