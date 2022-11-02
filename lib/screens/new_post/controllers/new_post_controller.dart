import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? pickedImage;

  @override
  void onInit() {
    super.onInit();

    image = null;
    pickedImage = null;
  }

  handlePickingImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = File(image!.path);
    }
    update();
  }

  handleTakingPhoto() async {
    image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      pickedImage = File(image!.path);
    }
    update();
  }
}
