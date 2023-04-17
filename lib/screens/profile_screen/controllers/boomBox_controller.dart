import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart'
    as user;
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:boom_mobile/screens/profile_screen/models/boom_box_model.dart';
import 'package:boom_mobile/screens/profile_screen/models/upload_photo_model.dart';
import 'package:boom_mobile/screens/profile_screen/service/boom_box_service.dart';
import 'package:boom_mobile/utils/colors.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class BoomBoxController extends GetxController {
  final TextEditingController boomBoxNameController = TextEditingController();
  final box = GetStorage();
  final formKey = GlobalKey<FormState>();
  late user.BoomUsers boomUsers;
  final dmService = DMService();
  final boomBoxService = BoomBoxService();
  XFile? boxImage;

  bool isLoading = false;

  List<user.User>? _users;
  List<user.User>? get users => _users;

  List<BoomBox> boomBoxes = [];
  // List<BoomBoxModel>? get boomBoxes => _boomBoxes;
  final ImagePicker _picker = ImagePicker();
  XFile? boomBoxImage;

  List<user.User> selectedUsers = [];

  @override
  void onInit() {
    fetchUserBoomBoxes();
    fetchUsers();
    super.onInit();
  }

  @override
  void onClose() {
    boomBoxNameController.dispose();
    super.onClose();
  }

  //fetch BoomUsers

  fetchUsers() async {
    var ress = await dmService.fetchUsers();
    final myUserId = box.read("useId");
    if (ress != null) {
      _users = [...ress];
      _users!.removeWhere((element) => element.id == myUserId);
      update();
    }
  }

  fetchUserBoomBoxes() async {
    isLoading = true;
    update();
    final ress = await boomBoxService.fetchUserBoomBox();
    boomBoxes.clear();
    if (ress.statusCode == 200) {
      for (var item in BoomBoxModel.fromJson(jsonDecode(ress.body)).boomBoxes) {
        boomBoxes.add(item);
      }

      isLoading = false;
      update();
    } else {
      Get.snackbar(
        "Error",
        "Error fetching boomboxes",
        backgroundColor: kredCancelLightColor,
        snackPosition: SnackPosition.BOTTOM,
      );
      isLoading = false;
      update();
    }
  }

  pickBoxImage(ImageSource theSource) async {
    boomBoxImage = await _picker.pickImage(source: theSource);
    update();
  }

  uploadBoxImage() async {}

  selectUsers(index) {
    if (selectedUsers.contains(users![index])) {
      selectedUsers.remove(users![index]);
    } else {
      selectedUsers.add(users![index]);
    }
    update();
  }

  createBox() async {
    String imageUrl = '';
    //Upload Image
    File photo = File(boomBoxImage!.path);

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

        imageUrl = uploadPhotoModel.url;
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

    //Create BoomBox and add to user's boombox list

    EasyLoading.show(status: "Creating BoomBox");
    final token = box.read("token");
    final userId = box.read("userId");
    final members = selectedUsers.map((e) => e.id).toList();
    final body = {
      "members": members,
      "image_url": imageUrl,
      "label": boomBoxNameController.text.trim(),
      "timestamp": DateTime.now().millisecondsSinceEpoch,
      "is_group_chat": true
    };

    final res = await http.post(
      Uri.parse("${baseURL}boom-box"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
    if (res.statusCode == 200) {
      //Enter the created boombox

      EasyLoading.dismiss();
      EasyLoading.showSuccess("BoomBox created");
      Get.back();
      fetchUserBoomBoxes();
      Get.snackbar("Error", "Error entering boombox",
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } else {
      log(res.body);
      EasyLoading.dismiss();
      Get.snackbar(
        "Error",
        "Could not create boombox",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }
}
