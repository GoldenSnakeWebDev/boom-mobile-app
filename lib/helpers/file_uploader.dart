import 'dart:convert';
import 'dart:io';
import 'package:boom_mobile/screens/profile_screen/models/upload_photo_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class FileUploader {
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

        return uploadPhotoModel.url;
      } else {
        EasyLoading.showError('Error uploading photo');
        response.stream.transform(utf8.decoder).listen((event) {});
      }
    } catch (e) {
      EasyLoading.showError('failed');

      return false;
    }
  }
}
