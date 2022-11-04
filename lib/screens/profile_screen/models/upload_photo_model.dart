// To parse this JSON data, do
//
//     final uploadPhotoModel = uploadPhotoModelFromJson(jsonString);

import 'dart:convert';

UploadPhotoModel uploadPhotoModelFromJson(String str) =>
    UploadPhotoModel.fromJson(json.decode(str));

String uploadPhotoModelToJson(UploadPhotoModel data) =>
    json.encode(data.toJson());

class UploadPhotoModel {
  UploadPhotoModel({
    required this.status,
    required this.url,
    required this.message,
  });

  String status;
  String url;
  String message;

  factory UploadPhotoModel.fromJson(Map<String, dynamic> json) =>
      UploadPhotoModel(
        status: json["status"],
        url: json["url"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "url": url,
        "message": message,
      };
}
