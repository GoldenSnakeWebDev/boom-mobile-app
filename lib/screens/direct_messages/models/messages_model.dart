//     final dMsResponse = dMsResponseFromJson(jsonString);

import 'dart:convert';

DMsResponse dMsResponseFromJson(String str) =>
    DMsResponse.fromJson(json.decode(str));

String dMsResponseToJson(DMsResponse data) => json.encode(data.toJson());

class DMsResponse {
  DMsResponse({
    this.status,
    this.boomBox,
  });

  String? status;
  DMBoomBox? boomBox;

  factory DMsResponse.fromJson(Map<String, dynamic> json) => DMsResponse(
        status: json["status"],
        boomBox: DMBoomBox.fromJson(json["boom_box"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "boom_box": boomBox?.toJson(),
      };
}

class DMBoomBox {
  DMBoomBox({
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
  List<DMMessage>? messages;
  bool? isActive;
  DateTime? createdAt;
  String? id;

  factory DMBoomBox.fromJson(Map<String, dynamic> json) => DMBoomBox(
        boxType: json["box_type"],
        imageUrl: json["image_url"],
        label: json["label"],
        box: json["box"],
        messages: List<DMMessage>.from(
            json["messages"].map((x) => DMMessage.fromJson(x))),
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

class DMMessage {
  DMMessage({
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

  factory DMMessage.fromJson(Map<String, dynamic> json) => DMMessage(
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
