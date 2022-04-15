import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class PoseNetModel {
  late Interpreter _interpreter;
  final _modelFile =
      "model/lite-model_movenet_singlepose_lightning_tflite_float16_4.tflite";
  PoseNetModel() {
    _loadModel();
  }

  _loadModel() async {
    debugPrint("interpreter start ");
    _interpreter =
        await Interpreter.fromAsset(_modelFile, options: InterpreterOptions());
    debugPrint("interpreter Loadded Successsfully");

    debugPrint("Input tensor : ${_interpreter.getInputTensors()}");
    debugPrint("Output tensout : ${_interpreter.getOutputTensors()}");
  }

  classify() {}
}
