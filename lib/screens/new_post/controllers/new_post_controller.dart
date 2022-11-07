import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/main_screen/main_screen.dart';
import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/screens/new_post/services/upload_boom.dart';
import 'package:boom_mobile/screens/profile_screen/controllers/edit_profile_controler.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum POST_TYPE { image, video, text }

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
  NetworkModel? networkModel = Get.find<MainScreenController>().networkModel;
  String? selectedNetwork;
  Network? selectedNetworkModel;
  List<String> networks = [];

  @override
  void onInit() {
    super.onInit();
    selectedNetwork = networkModel!.networks[0].symbol;
    selectedNetworkModel = networkModel!.networks[0];
    networks.clear();
    for (var element in networkModel!.networks) {
      networks.add(element.symbol);
    }
    image = null;
    pickedImage = null;
  }

  changeChain(String value) {
    selectedNetwork = value;
    for (var element in networkModel!.networks) {
      if (element.symbol == value) {
        selectedNetworkModel = element;
      }
    }
    update();
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
    String postType = '';
    String imgURL = '';
    pickedImage == null && boomText.text.trim().isNotEmpty
        ? postType = 'text'
        : postType = 'image';
    if (postType != 'text') {
      imgURL = await EditProfileController().uploadPhoto(pickedImage!);
    } else {
      imgURL = boomText.text.trim();
    }

    log("Boom Type $postType");
    NewPostModel newPostModel = NewPostModel(
        boomType: postType,
        network: selectedNetworkModel!.id,
        description: description.text.trim(),
        title: title.text.trim(),
        imageUrl: imgURL,
        quantity: quantity.text.trim(),
        tags: tags.text.trim(),
        fixedPrice: price.text.trim(),
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
