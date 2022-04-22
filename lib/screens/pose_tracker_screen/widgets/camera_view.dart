import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:gruham_yogi/core/utils/ui_constant.dart';

import '../../../../main.dart';

enum ScreenMode { liveFeed, gallery }

class CameraView extends StatefulWidget {
  const CameraView({
    Key? key,
    required this.title,
    required this.customPaint,
    required this.onImage,
    this.initialDirection = CameraLensDirection.back,
  }) : super(key: key);

  final String title;
  final CustomPaint? customPaint;
  final Future<String> Function(InputImage inputImage) onImage;
  final CameraLensDirection initialDirection;

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  ScreenMode _mode = ScreenMode.liveFeed;
  CameraController? _controller;
  File? _image;
  int _cameraIndex = 0;
  double zoomLevel = 0.0, minZoomLevel = 0.0, maxZoomLevel = 0.0;
  String poseName = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    for (var i = 0; i < cameras.length; i++) {
      if (cameras[i].lensDirection == widget.initialDirection) {
        _cameraIndex = i;
      }
    }
    _startLiveFeed();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // if (state == AppLifecycleState.inactive) {
    //   debugPrint("inactive state of app");
    //   // cameraController.dispose();
    //   _stopLiveFeed();
    // } else if (state == AppLifecycleState.resumed) {
    //   debugPrint("resume state of app");
    //   _startLiveFeed();
    // }
    final CameraController? cameraController = _controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.stopImageStream();
      // _stopLiveFeed();
    } else if (state == AppLifecycleState.resumed) {
      _startLiveFeed();
    }
  }

  @override
  void dispose() {
    _stopLiveFeed();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? _floatingActionButton() {
    if (_mode == ScreenMode.gallery) return null;
    if (cameras.length == 1) return null;
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Platform.isIOS
            ? Icons.flip_camera_ios_outlined
            : Icons.flip_camera_android_outlined,
        size: 40,
        color: Colors.white,
      ),
      onPressed: _switchLiveCamera,
    );
  }

  Widget _body() {
    return _liveFeedBody();
  }

  Widget _liveFeedBody() {
    // if (_controller == null || _controller?.value.isInitialized == false) {
    //   return Container();
    // }
    // final size = MediaQuery.of(context).size;

    // // calculate scale for aspect ratio widget
    // var scale = _controller!.value.aspectRatio / size.aspectRatio;

    // // check if adjustments are needed...
    // if (_controller!.value.aspectRatio < size.aspectRatio) {
    //   scale = 1 / scale;
    // }
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        // ClipRect(
        //     child: OverflowBox(
        //   alignment: Alignment.center,
        //   child: FittedBox(
        //       fit: BoxFit.fitWidth,
        //       child: Container(
        //           width: size.width,
        //           height: size.height / _controller!.value.aspectRatio,
        //           child: AspectRatio(
        //             aspectRatio: _controller!.value.aspectRatio,
        //             child: CameraPreview(_controller!),
        //           ))),
        // )),
        _controller != null && _controller!.value.isInitialized
            ? CameraPreview(_controller!)
            : Container(),
        if (widget.customPaint != null) widget.customPaint!,
        if (poseName != "")
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(space3x),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(space3x),
                  color: Colors.black26),
              child: Text(
                poseName,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Colors.white),
              ),
            ),
          )
        // Positioned(
        //   bottom: 100,
        //   left: 50,
        //   right: 50,
        //   child: Slider(
        //     value: zoomLevel,
        //     min: minZoomLevel,
        //     max: maxZoomLevel,
        //     onChanged: (newSliderValue) {
        //       setState(() {
        //         zoomLevel = newSliderValue;
        //         _controller!.setZoomLevel(zoomLevel);
        //       });
        //     },
        //     divisions: (maxZoomLevel - 1).toInt() < 1
        //         ? null
        //         : (maxZoomLevel - 1).toInt(),
        //   ),
        // )
      ],
    );
  }

  void _switchScreenMode() async {
    if (_mode == ScreenMode.liveFeed) {
      _mode = ScreenMode.gallery;
      await _stopLiveFeed();
    } else {
      _mode = ScreenMode.liveFeed;
      await _startLiveFeed();
    }
    setState(() {});
  }

  Future _startLiveFeed() async {
    final camera = cameras[_cameraIndex];
    _controller = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.bgra8888,
    );
    _controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _controller
          ?.getMaxZoomLevel()
          .then((double value) => maxZoomLevel = value);
      _controller
          ?.getMinZoomLevel()
          .then((double value) => minZoomLevel = value);

      _controller?.startImageStream(_processCameraImage);
    });
  }

  Future _stopLiveFeed() async {
    await _controller?.stopImageStream();
    await _controller?.dispose();
  }

  _switchLiveCamera() async {
    if (_cameraIndex == 0) {
      _cameraIndex = 1;
    } else {
      _cameraIndex = 0;
    }

    await _stopLiveFeed();
    await _startLiveFeed();
  }

  Future _processCameraImage(CameraImage image) async {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());

    final camera = cameras[_cameraIndex];
    final imageRotation =
        InputImageRotationMethods.fromRawValue(camera.sensorOrientation) ??
            InputImageRotation.Rotation_0deg;

    print("inputImageFormat : ${image.format.raw}");

    final inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ??
            InputImageFormat.BGRA8888;

    final planeData = image.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );
    // Uint8List? compressBytes = await FlutterImageCompress.compressWithList(
    //   bytes,
    //   minHeight: imageSize.height.toInt(),
    //   minWidth: imageSize.width.toInt(),
    //   quality: 80,
    // );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    poseName = await widget.onImage(inputImage);
  }
}
