import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class Classifer {
  late Interpreter _interpreter;
  final _modelFile = 'model/pose_classfication.tflite';

  final List<double> _mean = [
    83.711965,
    57.310682,
    63.684162,
    112.674696,
    112.788284,
    114.227378,
    144.125148,
    95.623230,
    19.230930,
    22.712689,
    138.604043,
    133.861544
  ];
  final List<double> _std = [
    107.048962,
    239.836178,
    117.398647,
    165.392692,
    95.543240,
    55.111020,
    292.587898,
    33.866420,
    29.563071,
    33.340180,
    52.330008,
    54.994803
  ];

  final List<String> _yogaPose = [
    "Dog",
    "chair",
    "cobra",
    "dog",
    "downdog",
    "goddess",
    "plank",
    "shoulder_stand",
    "triangle",
    "tree",
    "warrior",
    "warrior2"
  ];

  Classifer() {
    _loadModel();
  }

  List<double> norm(List<double> input) {
    List<double> normed_output = [];
    for (int i = 0; i < _mean.length; i++) {
      normed_output.add((input[i] - _mean[i]) / _std[i]);
    }
    return normed_output;
  }

  _loadModel() async {
    debugPrint("interpreter start ");
    _interpreter =
        await Interpreter.fromAsset(_modelFile, options: InterpreterOptions());
    debugPrint("interpreter Loadded Successsfully");

    debugPrint("Input tensor : ${_interpreter.getInputTensors()}");
    debugPrint("Output tensout : ${_interpreter.getOutputTensors()}");
  }

  String classify(List<double> input) {
    final normed_input = norm(input);
    final output = List<double>.filled(12, 1).reshape([1, 12]);

    print("before model classification : ${output.shape[1]}");
    _interpreter.run(normed_input, output);
    // final index = output.
    double temp_max = -999;
    int temp_max_idx = 0;
    for (var i = 0; i < output.shape[1]; i++) {
      if (temp_max < output[0][i]) {
        temp_max = output[0][i];
        temp_max_idx = i;
      }
    }
    // print("**** output : ${output[0]}");
    // print("**** class index : $temp_max_idx");
    return _yogaPose[temp_max_idx];
  }

  poseAnlysis() {}
}
