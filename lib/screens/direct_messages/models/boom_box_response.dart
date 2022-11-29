//     final dmResponse = dmResponseFromJson(jsonString);

import 'dart:convert';

DmResponse dmResponseFromJson(String str) =>
    DmResponse.fromJson(json.decode(str));

String dmResponseToJson(DmResponse data) => json.encode(data.toJson());

class DmResponse {
  DmResponse({
    this.status,
    this.page,
    this.boomBoxes,
  });

  String? status;
  Page? page;
  List<BoomBox>? boomBoxes;

  factory DmResponse.fromJson(Map<String, dynamic> json) => DmResponse(
        status: json["status"],
        page: Page.fromJson(json["page"]),
        boomBoxes: List<BoomBox>.from(
            json["boom_boxes"].map((x) => BoomBox.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "page": page?.toJson(),
        "boom_boxes": List<dynamic>.from(boomBoxes!.map((x) => x.toJson())),
      };
}

class BoomBox {
  BoomBox({
    this.boxType,
    this.imageUrl,
    this.label,
    this.box,
    this.isActive,
    this.messages,
    this.createdAt,
    this.id,
  });

  String? boxType;
  String? imageUrl;
  String? label;
  String? box;
  bool? isActive;
  List<Message>? messages;
  DateTime? createdAt;
  String? id;

  factory BoomBox.fromJson(Map<String, dynamic> json) => BoomBox(
        boxType: json["box_type"],
        imageUrl: json["image_url"],
        label: json["label"],
        box: json["box"],
        isActive: json["is_active"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "box_type": boxType,
        "image_url": imageUrl,
        "label": label,
        "box": box,
        "is_active": isActive,
        "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
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
    this.firstName,
    this.lastName,
    this.username,
    this.photo,
    this.id,
  });

  String? firstName;
  String? lastName;
  String? username;
  String? photo;
  String? id;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "id": id,
      };
}

class Page {
  Page();

  factory Page.fromJson(Map<String, dynamic> json) => Page();

  Map<String, dynamic> toJson() => {};
}
