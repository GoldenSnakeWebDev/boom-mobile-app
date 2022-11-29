//     final messagesData = messagesDataFromJson(jsonString);

import 'dart:convert';

MessagesData messagesDataFromJson(String str) =>
    MessagesData.fromJson(json.decode(str));

String messagesDataToJson(MessagesData data) => json.encode(data.toJson());

class MessagesData {
  MessagesData({
    this.id,
    this.boxType,
    this.imageUrl,
    this.label,
    this.box,
    this.isActive,
    this.messages,
    this.createdAt,
    this.v,
  });

  String? id;
  String? boxType;
  String? imageUrl;
  String? label;
  String? box;
  bool? isActive;
  List<Message>? messages;
  DateTime? createdAt;
  int? v;

  factory MessagesData.fromJson(Map<String, dynamic> json) => MessagesData(
        id: json["_id"],
        boxType: json["box_type"],
        imageUrl: json["image_url"],
        label: json["label"],
        box: json["box"],
        isActive: json["is_active"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "box_type": boxType,
        "image_url": imageUrl,
        "label": label,
        "box": box,
        "is_active": isActive,
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "__v": v,
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
  });

  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? photo;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
      };
}
