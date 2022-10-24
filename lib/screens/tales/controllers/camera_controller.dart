import 'dart:developer';

import 'package:boom_mobile/screens/tales/services/camera_service.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class TalesController extends GetxController {
  final cameraService = CameraService();
  List<CameraDescription> cameras = <CameraDescription>[];
  CameraController? cameraController;
  FlashMode? flashMode = FlashMode.off;

  // loadDefaultCamera() async {}

  @override
  void onInit() async {
    cameraService.init().then((value) {
      cameras = value;
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: true,
      );
      cameraController?.initialize().then((value) {
        log('Initialized');
        update();
      });
    });
    super.onInit();
  }
}
