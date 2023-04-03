import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:boom_mobile/models/fetch_tales_model.dart';
import 'package:boom_mobile/models/post_status_model.dart';
import 'package:boom_mobile/screens/profile_screen/models/upload_photo_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class TalesService {
  final _storage = GetStorage();

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
      log(basename(photo.path));
      var response = await request.send();

      if (response.statusCode == 201) {
        final respStr = await response.stream.bytesToString();
        UploadPhotoModel uploadPhotoModel =
            UploadPhotoModel.fromJson(json.decode(respStr));

        successMessage.isNotEmpty
            ? EasyLoading.showSuccess(successMessage)
            : null;

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

  // fetch tales
  Future<dynamic> fetchTales() async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.get(
        Uri.parse('${baseURL}statuses?page=all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final fetchStatusModel = fetchStatusModelFromJson(response.body);

        return fetchStatusModel.statuses;
      } else {
        log("Tales error >> ${response.body}");
        EasyLoading.showError('Error fetching tales');
        return null;
      }
    } catch (e) {
      log("Tales error caught >> $e");
      log("Tales error caught >> $token");
      EasyLoading.showError('Error fetching tales');
      return null;
    }
  }

  Future<dynamic> postTale(String imageUrl, String statusType) async {
    EasyLoading.show(status: 'Posting tale...');
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.post(
        Uri.parse('${baseURL}statuses'),
        headers: headers,
        body: jsonEncode({
          "status_type": statusType,
          "image_url": imageUrl,
        }),
      );
      log('Post tale response >> ${response.body}');
      if (response.statusCode == 201) {
        final postStatusModel = postStatusModelFromJson(response.body);
        EasyLoading.showSuccess("${postStatusModel.message}");
        return postStatusModel.statusData;
      } else {
        log('Post tale error >> ${response.body}');
        EasyLoading.showError('Error posting tale');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error posting tale');
      return null;
    }
  }
}
