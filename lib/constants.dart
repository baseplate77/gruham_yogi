import 'package:gruham_yogi/model/asana_model.dart';
import 'package:gruham_yogi/model/yoga_card_model.dart';

const String appName = "Gruham Yogi";

const String tagLine = "A healthy outside starts from a healthy inside.";

final yogaPoseList = [
  AsanaModel(
      imagePath: "assets/images/pose/boat-min.jpg", asanaName: "Boat Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/camel-min.jpg", asanaName: "Camel Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/cowface-min.jpg",
      asanaName: "Cowface Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/Dancer-min.jpg",
      asanaName: "Dancer Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/downdog-min.jpg",
      asanaName: "Downward Dog Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/goddess-min.jpg",
      asanaName: "Goddess Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/plank-min.jpg", asanaName: "Plank Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/tree-min.jpg", asanaName: "Tree Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/warrior1-min.jpg",
      asanaName: "Warrior 1 Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/warrior-min.jpg",
      asanaName: "Warrior 2 Asana"),
  AsanaModel(
      imagePath: "assets/images/pose/wheel-min.jpg", asanaName: "Wheel Asana"),
];

final yogaCardData = [
  YogaCardModel(
    bgImagePath: "assets/images/beginner_pose_sm.jpg",
    levelName: "Beginner",
    asanaCount: 10,
    duration: "10 min",
  ),
  YogaCardModel(
    bgImagePath: "assets/images/intermidiate_pose_sm.jpg",
    levelName: "Intermediate",
    asanaCount: 10,
    duration: "35 min",
  ),
  YogaCardModel(
    bgImagePath: "assets/images/advance_pose_sm.jpg",
    levelName: "Advance",
    asanaCount: 10,
    duration: "40 min",
  ),
];
