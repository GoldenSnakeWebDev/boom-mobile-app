// To parse this JSON data, do
//
//     final boomBoxModel = boomBoxModelFromJson(jsonString);

import 'dart:convert';

BoomBoxModel boomBoxModelFromJson(String str) =>
    BoomBoxModel.fromJson(json.decode(str));

String boomBoxModelToJson(BoomBoxModel data) => json.encode(data.toJson());

class BoomBoxModel {
  BoomBoxModel({
    required this.status,
    required this.boomBoxes,
  });

  String status;
  List<BoomBox> boomBoxes;

  factory BoomBoxModel.fromJson(Map<String, dynamic> json) => BoomBoxModel(
        status: json["status"],
        boomBoxes: List<BoomBox>.from(
            json["boomBoxes"].map((x) => BoomBox.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "boomBoxes": List<dynamic>.from(boomBoxes.map((x) => x.toJson())),
      };
}

class BoomBox {
  BoomBox({
    required this.isGroup,
    required this.boxType,
    required this.imageUrl,
    required this.label,
    required this.user,
    required this.members,
    required this.createdAt,
    required this.isActive,
    required this.isDeleted,
    required this.messages,
    required this.id,
  });

  bool isGroup;
  String boxType;
  String imageUrl;
  String label;
  User user;
  List<Member> members;
  DateTime createdAt;
  bool isActive;
  bool isDeleted;
  List<Message> messages;
  String id;

  factory BoomBox.fromJson(Map<String, dynamic> json) => BoomBox(
        isGroup: json["is_group"],
        boxType: json["box_type"],
        imageUrl: json["image_url"],
        label: json["label"],
        user: User.fromJson(json["user"]),
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
        isDeleted: json["is_deleted"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "is_group": isGroup,
        "box_type": boxType,
        "image_url": imageUrl,
        "label": label,
        "user": user.toJson(),
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "created_at": createdAt.toIso8601String(),
        "is_active": isActive,
        "is_deleted": isDeleted,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "id": id,
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

  User user;
  DateTime createdAt;
  bool isAdmin;
  bool isBurnt;
  String id;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        user: User.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        isAdmin: json["is_admin"],
        isBurnt: json["is_burnt"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "created_at": createdAt.toIso8601String(),
        "is_admin": isAdmin,
        "is_burnt": isBurnt,
        "_id": id,
      };
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.photo,
    required this.userId,
  });

  String id;
  String firstName;
  String lastName;
  String username;
  String photo;
  String userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        userId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "id": userId,
      };
}

class Message {
  Message({
    required this.sender,
    required this.createdAt,
    required this.content,
    required this.id,
  });

  User sender;
  DateTime createdAt;
  String content;
  String id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        sender: User.fromJson(json["sender"]),
        createdAt: DateTime.parse(json["created_at"]),
        content: json["content"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "sender": sender.toJson(),
        "created_at": createdAt.toIso8601String(),
        "content": content,
        "_id": id,
      };
}
