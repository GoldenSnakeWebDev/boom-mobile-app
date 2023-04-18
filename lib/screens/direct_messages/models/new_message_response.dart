// To parse this JSON data, do
//
//     final newBoomBoxResponse = newBoomBoxResponseFromJson(jsonString);

import 'dart:convert';

import '../../profile_screen/models/boom_box_model.dart';

NewBoomBoxResponse newBoomBoxResponseFromJson(String str) =>
    NewBoomBoxResponse.fromJson(json.decode(str));

String newBoomBoxResponseToJson(NewBoomBoxResponse data) =>
    json.encode(data.toJson());

class NewBoomBoxResponse {
  NewBoomBoxResponse({
    required this.status,
    required this.boomBox,
    required this.message,
  });

  String status;
  BoomBox boomBox;
  String message;

  factory NewBoomBoxResponse.fromJson(Map<String, dynamic> json) =>
      NewBoomBoxResponse(
        status: json["status"],
        boomBox: BoomBox.fromJson(json["boomBox"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "boomBox": boomBox.toJson(),
        "message": message,
      };
}

class Member {
  Member({
    required this.user,
    required this.createdAt,
    required this.isAdmin,
    required this.isBurnt,
    required this.id,
  });

  String user;
  DateTime createdAt;
  bool isAdmin;
  bool isBurnt;
  String id;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        user: json["user"],
        createdAt: DateTime.parse(json["created_at"]),
        isAdmin: json["is_admin"],
        isBurnt: json["is_burnt"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "created_at": createdAt.toIso8601String(),
        "is_admin": isAdmin,
        "is_burnt": isBurnt,
        "_id": id,
      };
}

class Message {
  Message({
    required this.sender,
    required this.createdAt,
    required this.content,
    required this.id,
  });

  String sender;
  DateTime createdAt;
  String content;
  String id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: json["sender"],
        createdAt: DateTime.parse(json["created_at"]),
        content: json["content"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender,
        "created_at": createdAt.toIso8601String(),
        "content": content,
        "_id": id,
      };
}
