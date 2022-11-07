import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/screens/main_screen/controllers/main_screen_controller.dart';
import 'package:boom_mobile/screens/profile_screen/models/upload_photo_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import '../../authentication/login/models/user_model.dart';
import 'package:http/http.dart' as http;

class EditProfileController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  final box = GetStorage();
  final User? user = Get.find<MainScreenController>().user;
  final ImagePicker _picker = ImagePicker();
  XFile? headerImage;
  XFile? profileImage;
  File? pickedHeaderImage;
  File? pickedProfileImage;
  String headerUrl = "";
  String profileUrl = "";

  @override
  void onInit() {
    usernameController.text = user!.username;

    super.onInit();
  }

  handlePickHeaderImage() async {
    headerImage = await _picker.pickImage(source: ImageSource.gallery);
    if (headerImage != null) {
      pickedHeaderImage = File(headerImage!.path);
    }
    update();
  }

  handlePickProfileImage() async {
    profileImage = await _picker.pickImage(source: ImageSource.gallery);
    if (profileImage != null) {
      pickedProfileImage = File(profileImage!.path);
    }
    update();
  }

  uploadPhoto(File photo) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${baseURL}helpers/docs-uploads"),
      );

      var stream = http.ByteStream(Stream.castFrom(photo.openRead()));
      var length = photo.lengthSync();
      final mimeTypeData =
          lookupMimeType(photo.path, headerBytes: [0xFF, 0xD8])!.split('/');
      var multipartFile = http.MultipartFile(
        "doc",
        stream,
        length,
        filename: basename(photo.path),
        contentType: MediaType(
          mimeTypeData[0],
          mimeTypeData[1],
        ),
      );
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
      };
      request.headers.addAll(headers);

      request.files.add(multipartFile);
      // request.fields["doc"] = basename(photo.path);
      log(basename(photo.path));
      var response = await request.send();

      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        UploadPhotoModel uploadPhotoModel =
            UploadPhotoModel.fromJson(json.decode(respStr));

        EasyLoading.showSuccess('Profile photo uploaded!');
        update();
        return uploadPhotoModel.url;
      } else {
        log('ErrorCode >> ${response.statusCode}');
        EasyLoading.showError('Error uploading photo');
        response.stream.transform(utf8.decoder).listen((event) {
          log(event);
        });
      }
    } catch (e) {
      EasyLoading.showError('failed');
      log('Upload exception >> $e');
      return false;
    }
  }

  updateProfile() async {
    String token = box.read("token");

    EasyLoading.show(status: 'Updating profile...');

    if (profileImage != null && headerImage != null) {
      profileUrl = await uploadPhoto(pickedProfileImage!);
      headerUrl = await uploadPhoto(pickedHeaderImage!);
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            // "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
            "photo": profileUrl,
            "cover": headerUrl,
          },
        ),
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Profile updated!');
        Get.back();
      } else {
        log(res.body);
        EasyLoading.showError('Error updating profile');
      }
    } else if (profileImage != null) {
      profileUrl = await uploadPhoto(pickedProfileImage!);
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            // "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
            "photo": profileUrl
          },
        ),
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Profile updated!');
        Get.back();
      } else {
        log(res.body);
        EasyLoading.showError('Error updating profile');
      }
    } else if (headerImage != null) {
      headerUrl = await uploadPhoto(pickedHeaderImage!);
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            // "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
            "cover": headerUrl
          },
        ),
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Profile updated!');
        Get.back();
      } else {
        log(res.body);
        EasyLoading.showError('Error updating profile');
      }
    } else {
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            // "username": usernameController.text,

            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
          },
        ),
      );
      if (res.statusCode == 200) {
        EasyLoading.showSuccess('Profile updated!');
        Get.back();
      } else {
        log(res.body);
        EasyLoading.showError('Error updating profile');
      }
    }
  }
}