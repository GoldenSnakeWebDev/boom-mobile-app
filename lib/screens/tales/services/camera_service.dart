import 'package:camera/camera.dart';

class CameraService {
  List<CameraDescription> cameras = <CameraDescription>[];

  Future<List<CameraDescription>> init() async {
    cameras = await availableCameras();
    return cameras;
  }

  onNewCamerSelected() async {}
}
