import 'dart:math';

import 'package:google_ml_kit/google_ml_kit.dart';

List<List<PoseLandmarkType>> landmarkTypes = [
  [
    PoseLandmarkType.leftShoulder,
    PoseLandmarkType.leftElbow,
    PoseLandmarkType.leftHip
  ],
  [
    PoseLandmarkType.rightShoulder,
    PoseLandmarkType.rightElbow,
    PoseLandmarkType.rightHip
  ],
  [
    PoseLandmarkType.leftShoulder,
    PoseLandmarkType.rightShoulder,
    PoseLandmarkType.leftHip
  ],
  [
    PoseLandmarkType.rightShoulder,
    PoseLandmarkType.leftShoulder,
    PoseLandmarkType.rightHip
  ],
  [
    PoseLandmarkType.leftElbow,
    PoseLandmarkType.leftShoulder,
    PoseLandmarkType.leftWrist
  ],
  [
    PoseLandmarkType.leftElbow,
    PoseLandmarkType.rightShoulder,
    PoseLandmarkType.leftWrist
  ],
  [
    PoseLandmarkType.leftHip,
    PoseLandmarkType.rightHip,
    PoseLandmarkType.leftShoulder
  ],
  [
    PoseLandmarkType.rightHip,
    PoseLandmarkType.leftHip,
    PoseLandmarkType.rightShoulder
  ],
  [
    PoseLandmarkType.leftHip,
    PoseLandmarkType.leftKnee,
    PoseLandmarkType.leftAnkle
  ],
  [
    PoseLandmarkType.rightHip,
    PoseLandmarkType.rightKnee,
    PoseLandmarkType.rightAnkle
  ],
  [
    PoseLandmarkType.leftKnee,
    PoseLandmarkType.leftAnkle,
    PoseLandmarkType.leftHip
  ],
  [
    PoseLandmarkType.rightKnee,
    PoseLandmarkType.rightAnkle,
    PoseLandmarkType.rightHip
  ]
];

/// angle calcuator
List<double> angleCalculator(
  Map<PoseLandmarkType, PoseLandmark> landmark,
) {
  List<double> output = [];
  double? x1, x2, x3, y1, y2, y3, l1, l2, l3, cosTheta, arcCos;
  for (var lt in landmarkTypes) {
    x1 = landmark[lt[0]]?.x;
    y1 = landmark[lt[0]]?.y;

    x2 = landmark[lt[1]]?.x;
    y2 = landmark[lt[1]]?.y;

    x3 = landmark[lt[2]]?.x;
    y3 = landmark[lt[2]]?.y;

    l1 = sqrt(pow((x1! - x2!), 2) + pow((y1! - y2!), 2));
    l2 = sqrt(pow((x1 - x3!), 2) + pow((y1 - y3!), 2));
    l3 = sqrt(pow((x2 - x3), 2) + pow((y2 - y3), 2));
    cosTheta = (pow(l1, 2) + pow(l2, 2) - pow(l3, 2)) / (2 * l1 * l2);
    arcCos = acos(cosTheta) * (180 / pi);
    // print("arcCos : ${arcCos}");
    output.add(arcCos);
  }
  return output;

  // print("landmarks : ${landmarkIndex[0][2]}");
}
