import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/di/app_bindings.dart';
import 'package:boom_mobile/screens/tales/services/camera_service.dart';
import 'package:boom_mobile/screens/tales/ui/edit_tale_image.dart';
import 'package:camera/camera.dart';
import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class TalesController extends GetxController {
  final cameraService = CameraService();
  List<CameraDescription> cameras = <CameraDescription>[];
  late PhotoCameraState photoCameraState;
  late CameraController cameraController;
  bool isLoading = false;
  late String imagePath;
  final ImagePicker picker = ImagePicker();

  // loadDefaultCamera() async {}

  @override
  void onInit() {
    cameras = Get.arguments[0];
    // initCameras();
    super.onInit();
  }

  getPath(CaptureMode captureMode) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final Directory extDir = await getApplicationDocumentsDirectory();
    final dirPath =
        await Directory('${extDir.path}/Tales').create(recursive: true);
    final String filePath = '${dirPath.path}/$fileName.jpg';
    await CamerawesomePlugin.takePhoto(filePath);
    imagePath = filePath;
    File pickedImage = File(imagePath);
    update();
    onClose();
    Get.to(
      () => EditTaleImage(imageFile: pickedImage),
      binding: AppBindings(),
    );
  }

  pickPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
      File pickedImage = File(imagePath);
      update();
      Get.to(
        () => EditTaleImage(imageFile: pickedImage),
        binding: AppBindings(),
      );
    } else {
      log('No image selected.');
    }
  }

  initCameras() async {
    isLoading = true;
    if (cameras.isNotEmpty) {
      cameraController = CameraController(
        cameras[0],
        ResolutionPreset.ultraHigh,
        enableAudio: true,
      );

      update();

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
    CamerawesomePlugin.stop();
    super.onClose();
  }
}
