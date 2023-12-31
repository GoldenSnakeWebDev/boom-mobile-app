import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as Math;

import 'package:boom_mobile/models/network_model.dart';
import 'package:boom_mobile/screens/home_screen/controllers/home_controller.dart';
import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';
import 'package:boom_mobile/screens/profile_screen/models/upload_photo_model.dart';
import 'package:boom_mobile/screens/splash_screen/controllers/splash_controller.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:boom_mobile/widgets/custom_snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../authentication/login/models/user_model.dart';

typedef OnUploadProgressCallback = void Function(
    int byteCount, int totalByteCount);

class EditProfileController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController bnbWalletController = TextEditingController();
  TextEditingController tezosWalletController = TextEditingController();
  TextEditingController maticWalletController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController tiktokController = TextEditingController();
  TextEditingController mediumController = TextEditingController();
  TextEditingController currPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final box = GetStorage();
  User? user;
  final ImagePicker _picker = ImagePicker();
  XFile? headerImage;
  XFile? profileImage;
  File? pickedHeaderImage;
  File? pickedProfileImage;
  String headerUrl = "";
  String profileUrl = "";
  bool isLoadingBooms = false;
  AllBooms? myBooms;
  List<String> boomsURL = [];
  String selectedHeaderImage = "";
  String selectedProfileImage = "";
  NetworkModel? networkModel;

  @override
  void onInit() {
    user = Get.arguments[0];
    Get.put(SplashController());
    networkModel = Get.find<HomeController>().networkModel;

    usernameController.text = user!.username!;
    bioController.text = user!.bio!;
    locationController.text = user!.location!;
    bnbWalletController.text =
        user!.tippingInfo!.isNotEmpty ? user!.tippingInfo![0].address! : "";
    tezosWalletController.text =
        user!.tippingInfo!.length > 1 ? user!.tippingInfo![1].address! : "";
    maticWalletController.text =
        user!.tippingInfo!.length > 2 ? user!.tippingInfo![2].address! : "";
    twitterController.text = user!.socialMedia!.twitter!;
    facebookController.text = user!.socialMedia!.facebook!;
    instagramController.text = user!.socialMedia!.instagram!;
    tiktokController.text = user!.socialMedia!.tiktok!;
    mediumController.text = user!.socialMedia!.medium!;

    fetchMyBooms();
    super.onInit();
  }

  handlePickHeaderImage(ImageSource theSource) async {
    headerImage = await _picker.pickImage(source: theSource);
    if (headerImage != null) {
      // pickedHeaderImage = File(headerImage!.path);
      // crop
      final cropImageFile = await ImageCropper().cropImage(
          sourcePath: headerImage!.path,
          // maxWidth: 400,
          // maxHeight: 300,
          cropStyle: CropStyle.rectangle,
          // aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
          compressFormat: ImageCompressFormat.png,
          compressQuality: 0);
      pickedHeaderImage = File(cropImageFile!.path);

      // final imgSize = File(cropImageFile.path);
      // final fileSize = await getFileSize(imgSize);
      // log(fileSize);

      // 211.77 KB
      // 851.33 KB
    }
    update();
  }

  getFileSize(File file) async {
    int size = await file.length();
    if (size <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (Math.log(size) / Math.log(1024)).floor();

    return "${((size / Math.pow(1024, i))).toStringAsFixed(2)} ${suffixes[i]}";
  }

  handlePickProfileImage(ImageSource theSource) async {
    profileImage = await _picker.pickImage(source: theSource);
    if (profileImage != null) {
      // pickedProfileImage = File(profileImage!.path);
      final cropImageFile = await ImageCropper().cropImage(
        sourcePath: profileImage!.path,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 10,
      );
      pickedProfileImage = File(cropImageFile!.path);
    }
    update();
  }

  loadBoomImages() async {
    for (var item in myBooms!.booms!) {
      if (item.boomType == "image") {
        boomsURL.add(item.imageUrl!);
      }
    }
    update();
  }

  selectHeaderImage(String imgURL) {
    selectedHeaderImage = imgURL;
    update();
  }

  selectProfileImage(String imgURL) {
    selectedProfileImage = imgURL;
    update();
  }

  proceedWithUpload(String? image, String imgType) async {
    // await instragram.downloadMedia(media);

    if (image == null) {
      CustomSnackBar.showCustomSnackBar(
          errorList: ["Please Select an Image"], msg: ["Error"], isError: true);
    } else {
      HttpClient client = HttpClient();
      try {
        EasyLoading.show(status: "Downloading Image");
        var request = await client.getUrl(Uri.parse(image));
        var response = await request.close();
        if (response.statusCode == 200) {
          var bytes = await consolidateHttpClientResponseBytes(response);
          Directory dir = await getApplicationDocumentsDirectory();
          String date = DateTime.now().millisecondsSinceEpoch.toString();

          if (imgType == "header") {
            String filePath = '${dir.path}/$date.jpg';
            pickedHeaderImage = File(filePath);
            await pickedHeaderImage!.writeAsBytes(bytes);
            log(pickedHeaderImage!.exists().toString());
            EasyLoading.dismiss();
            Get.back();
            update();
          } else {
            String filePath = '${dir.path}/$date.jpg';
            pickedProfileImage = File(filePath);
            await pickedProfileImage!.writeAsBytes(bytes);
            log(pickedProfileImage!.exists().toString());
            EasyLoading.dismiss();
            Get.back();
            update();
          }
        } else {
          EasyLoading.dismiss();
          CustomSnackBar.showCustomSnackBar(
              errorList: ["Error Downloading Image"],
              msg: ["Error"],
              isError: true);
        }
      } catch (e) {
        CustomSnackBar.showCustomSnackBar(
            errorList: ["Error downloading image $e"],
            msg: ["Download Error"],
            isError: true);
      }
    }
  }

  fetchMyBooms() async {
    String token = box.read("token");
    String userId = box.read("userId");

    isLoadingBooms = true;
    final res = await http.get(
      Uri.parse("${baseURL}fetch-user-booms/$userId?page=all"),
      headers: {"Authorization": token},
    );
    if (res.statusCode == 200) {
      myBooms = AllBooms.fromJson(jsonDecode(res.body));
      await loadBoomImages();
      isLoadingBooms = false;
      update();
    } else {
      isLoadingBooms = false;
      log("My Booms res${res.body}");
      CustomSnackBar.showCustomSnackBar(
        errorList: ["Could not fetch your booms"],
        msg: ["Error"],
        isError: true,
      );
    }
  }

  uploadVideo(File video, String successMessage) async {
    try {
      // String fileName = video.path.split('/').last;
      final videoData = await video.readAsBytes();
      final mime = lookupMimeType(video.path, headerBytes: videoData);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${baseURL}helpers/docs-uploads"),
      );

      var stream = http.ByteStream(Stream.castFrom(video.openRead()));
      var length = video.lengthSync();

      var multipartFile = http.MultipartFile("doc", stream, length,
          filename: basename(video.path), contentType: MediaType.parse(mime!));
      Map<String, String> headers = {
        "Content-Type": "multipart/form-data",
        "Accept": "*/*",
      };
      request.headers.addAll(headers);

      request.files.add(multipartFile);
      // request.fields["doc"] = basename(photo.path);
      log(basename(video.path));
      var response = await request.send();

      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        UploadPhotoModel uploadPhotoModel =
            UploadPhotoModel.fromJson(json.decode(respStr));

        successMessage.isNotEmpty
            ? EasyLoading.showSuccess(successMessage)
            : null;
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

  uploadPhoto(File photo, String successMessage) async {
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

      var response = await request.send();

      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        UploadPhotoModel uploadPhotoModel =
            UploadPhotoModel.fromJson(json.decode(respStr));

        successMessage.isNotEmpty
            ? EasyLoading.showSuccess(successMessage)
            : null;
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

    List tippingInfo = [];

    for (var element in networkModel!.networks!) {
      if (element.symbol == "BNB") {
        final networkBody = {
          "network": element.id,
          "address": bnbWalletController.text.trim(),
        };
        tippingInfo.add(networkBody);
      } else if (element.symbol == "TZ") {
        final networkBody = {
          "network": element.id,
          "address": tezosWalletController.text.trim(),
        };
        tippingInfo.add(networkBody);
      } else if (element.symbol == "MATIC") {
        final networkBody = {
          "network": element.id,
          "address": maticWalletController.text.trim(),
        };
        tippingInfo.add(networkBody);
      }
    }

    String twitter = twitterController.text.trim();
    String facebook = facebookController.text.trim();
    String instagram = instagramController.text.trim();
    String tiktok = tiktokController.text.trim();
    String medium = mediumController.text.trim();

    if (pickedProfileImage != null && pickedHeaderImage != null) {
      profileUrl =
          await uploadPhoto(pickedProfileImage!, 'Profile photo uploaded!');
      headerUrl =
          await uploadPhoto(pickedHeaderImage!, 'Profile photo uploaded!');
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
            "photo": profileUrl,
            "cover": headerUrl,
            "tipping_info": tippingInfo,
            "social_media": {
              "facebook": facebook,
              "twitter": twitter,
              "instagram": instagram,
              "tiktok": tiktok,
              "medium": medium,
            },
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
    } else if (pickedProfileImage != null) {
      profileUrl =
          await uploadPhoto(pickedProfileImage!, 'Profile photo uploaded!');
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
            "photo": profileUrl,
            "tipping_info": tippingInfo,
            "social_media": {
              "facebook": facebook,
              "twitter": twitter,
              "instagram": instagram,
              "tiktok": tiktok,
              "medium": medium,
            },
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
    } else if (pickedHeaderImage != null) {
      headerUrl =
          await uploadPhoto(pickedHeaderImage!, 'Profile photo uploaded!');
      final res = await http.post(
        Uri.parse("${baseURL}users/update-profile"),
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode(
          {
            "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            // "website": websiteController.text,
            "cover": headerUrl,
            "tipping_info": tippingInfo,
            "social_media": {
              "facebook": facebook,
              "twitter": twitter,
              "instagram": instagram,
              "tiktok": tiktok,
              "medium": medium,
            },
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
            "username": usernameController.text,
            "email": user!.email,
            "bio": bioController.text,
            "location": locationController.text,
            "tipping_info": tippingInfo,
            "social_media": {
              "facebook": facebook,
              "twitter": twitter,
              "instagram": instagram,
              "tiktok": tiktok,
              "medium": medium,
            },
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

  changePassword() async {
    EasyLoading.show(status: 'Updating password...');
    final token = box.read("token");
    final body = {
      "current_password": currPasswordController.text.trim(),
      "new_password": newPasswordController.text.trim(),
      "confirm_password": confirmPasswordController.text.trim(),
    };
    final res = await http.post(
      Uri.parse("${baseURL}users/currentuser-update-password"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );

    if (res.statusCode == 200) {
      EasyLoading.showSuccess('Password updated!');
      Get.back();
      return true;
    } else {
      log("Res Body ${res.body}");
      log("Res Code ${res.statusCode}");
      EasyLoading.showError("Error updating password");
      return false;
    }
  }
}
