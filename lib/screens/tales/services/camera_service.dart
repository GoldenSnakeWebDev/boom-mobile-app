import 'dart:developer';

import 'package:camera/camera.dart';

class CameraService {
  List<CameraDescription> cameras = <CameraDescription>[];

  Future<List<CameraDescription>> init() async {
    cameras = await availableCameras();
    log("Camera Available ${cameras.length}");
    return cameras;
  }

  onNewCamerSelected() async {}
}
