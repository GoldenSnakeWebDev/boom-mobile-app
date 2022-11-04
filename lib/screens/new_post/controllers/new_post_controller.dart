import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/screens/new_post/services/upload_boom.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? pickedImage;
  UploadService uploadService = UploadService();

  TextEditingController title = TextEditingController();
  TextEditingController boomText = TextEditingController();
  TextEditingController tags = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController fixedPrice = TextEditingController();
  TextEditingController price = TextEditingController();

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

  uploadNewBoom() async {
    EasyLoading.show(status: "Uploading");
    NewPostModel newPostModel = NewPostModel(
        boomType: "text",
        network: "6362b237b11f989c35773a4b",
        description: description.text.trim(),
        title: title.text.trim(),
        imageUrl: boomText.text.trim(),
        quantity: quantity.text.trim(),
        tags: tags.text.trim(),
        fixedPrice: fixedPrice.text.trim(),
        price: price.text.trim());
    final res = await uploadService.uploadPost(newPostModel);

    if (res.statusCode == 201) {
      CustomSnackBar.showCustomSnackBar(
          errorList: [""], msg: [""], isError: false);
      Get.offAll(() => const MainScreen());
    } else {
      log(res.body);
      CustomSnackBar.showCustomSnackBar(
          errorList: [""], msg: [""], isError: true);
    }
    EasyLoading.dismiss();
  }
}
