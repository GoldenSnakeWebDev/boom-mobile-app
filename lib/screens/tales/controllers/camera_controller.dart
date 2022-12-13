import 'dart:developer';

import 'package:boom_mobile/screens/tales/services/camera_service.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class TalesController extends GetxController {
  final cameraService = CameraService();
  List<CameraDescription> cameras = <CameraDescription>[];
  CameraController? cameraController;
  FlashMode? flashMode;

  // loadDefaultCamera() async {}

  @override
  void onInit() {
    initCameras();
    super.onInit();
  }

  initCameras() async {
    await cameraService.init().then((value) async {
      cameras = value;
      final CameraController controller = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: true,
      );
      cameraController = controller;
      update();

      await cameraController?.initialize().then((value) {
        log('Initialized');
        update();
      });
    });
  }

  @override
  void onClose() {
    cameraController?.dispose();
    super.onClose();
  }
}
