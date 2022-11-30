// To parse this JSON data, do
//
//     final boomResponse = boomResponseFromJson(jsonString);

import 'dart:convert';

BoomResponse boomResponseFromJson(String str) =>
    BoomResponse.fromJson(json.decode(str));

String boomResponseToJson(BoomResponse data) => json.encode(data.toJson());

class BoomResponse {
  BoomResponse({
    this.status,
    this.boomBox,
  });

  String? status;
  List<BoomBox>? boomBox;

  factory BoomResponse.fromJson(Map<String, dynamic> json) => BoomResponse(
        status: json["status"],
        boomBox: List<BoomBox>.from(
            json["boom_box"].map((x) => BoomBox.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "boom_box": List<dynamic>.from(boomBox!.map((x) => x.toJson())),
      };
}

class BoomBox {
  BoomBox({
    this.boxType,
    this.imageUrl,
    this.label,
    this.box,
    this.messages,
    this.isActive,
    this.createdAt,
    this.id,
  });

  String? boxType;
  String? imageUrl;
  String? label;
  String? box;
  List<Message>? messages;
  bool? isActive;
  DateTime? createdAt;
  String? id;

  factory BoomBox.fromJson(Map<String, dynamic> json) => BoomBox(
        boxType: json["box_type"],
        imageUrl: json["image_url"],
        label: json["label"],
        box: json["box"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "box_type": boxType,
        "image_url": imageUrl,
        "label": label,
        "box": box,
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

class Message {
  Message({
    this.content,
    this.receiver,
    this.author,
    this.timestamp,
    this.isDelete,
    this.id,
  });

  String? content;
  Author? receiver;
  Author? author;
  DateTime? timestamp;
  bool? isDelete;
  String? id;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        content: json["content"],
        receiver: Author.fromJson(json["receiver"]),
        author: Author.fromJson(json["author"]),
        timestamp: DateTime.parse(json["timestamp"]),
        isDelete: json["is_delete"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "receiver": receiver?.toJson(),
        "author": author?.toJson(),
        "timestamp": timestamp?.toIso8601String(),
        "is_delete": isDelete,
        "_id": id,
      };
}

class Author {
  Author({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.photo,
    this.authorId,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? photo;
  String? authorId;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        authorId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "id": authorId,
      };
}
