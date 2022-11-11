//     final postStatusModel = postStatusModelFromJson(jsonString);

import 'dart:convert';

PostStatusModel postStatusModelFromJson(String str) =>
    PostStatusModel.fromJson(json.decode(str));

String postStatusModelToJson(PostStatusModel data) =>
    json.encode(data.toJson());

class PostStatusModel {
  PostStatusModel({
    this.status,
    this.message,
    this.statusData,
  });

  String? status;
  String? message;
  StatusData? statusData;

  factory PostStatusModel.fromJson(Map<String, dynamic> json) =>
      PostStatusModel(
        status: json["status"],
        message: json["message"],
        statusData: StatusData.fromJson(json["status_data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "status_data": statusData?.toJson(),
      };
}

class StatusData {
  StatusData({
    this.statusType,
    this.user,
    this.imageUrl,
    this.expiryTime,
    this.isActive,
    this.createdAt,
    this.id,
  });

  String? statusType;
  String? user;
  String? imageUrl;
  String? expiryTime;
  bool? isActive;
  DateTime? createdAt;
  String? id;

  factory StatusData.fromJson(Map<String, dynamic> json) => StatusData(
        statusType: json["status_type"],
        user: json["user"],
        imageUrl: json["image_url"],
        expiryTime: json["expiry_time"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status_type": statusType,
        "user": user,
        "image_url": imageUrl,
        "expiry_time": expiryTime,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
