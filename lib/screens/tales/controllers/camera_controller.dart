import 'dart:developer';

import 'package:boom_mobile/screens/tales/services/camera_service.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

class TalesController extends GetxController {
  final cameraService = CameraService();
  List<CameraDescription> cameras = <CameraDescription>[];
  late CameraController cameraController;
  FlashMode? flashMode;
  bool isLoading = false;

  // loadDefaultCamera() async {}

  @override
  void onInit() {
    cameras = Get.arguments[0];
    initCameras();
    super.onInit();
  }

  initCameras() async {
    isLoading = true;
    log("Camera Available ${cameras.length}");
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: true,
      );

      update();

      log("Flash Mode Camers ${cameraController.value.flashMode}");
      Future.delayed(const Duration(seconds: 1), () async {
        if (!cameraController.value.isInitialized) {
          try {
            await cameraController.initialize();
            isLoading = false;
            update();
          } catch (e) {
            isLoading = false;
            log("Could not initialize camera due to  $e");
          }
          // await cameraController.initialize().then((_) {
          //   log('Initialized');
          //   isLoading = false;
          //   update();
          // });
        }
      });
    } else {
      isLoading = false;
      log("Could not load cameras");
      update();
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
