// To parse this JSON data, do
//
//     final allBooms = allBoomsFromJson(jsonString);

import 'dart:convert';

AllBooms allBoomsFromJson(String str) => AllBooms.fromJson(json.decode(str));

String allBoomsToJson(AllBooms data) => json.encode(data.toJson());

class AllBooms {
  AllBooms({
    required this.status,
    required this.page,
    required this.booms,
  });

  String status;
  Page page;
  List<Boom> booms;

  factory AllBooms.fromJson(Map<String, dynamic> json) => AllBooms(
        status: json["status"],
        page: Page.fromJson(json["page"]),
        booms: List<Boom>.from(json["booms"].map((x) => Boom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "page": page.toJson(),
        "booms": List<dynamic>.from(booms.map((x) => x.toJson())),
      };
}

class Boom {
  Boom({
    required this.boomType,
    required this.title,
    required this.boomState,
    required this.isMinted,
    required this.description,
    required this.network,
    required this.comments,
    required this.user,
    required this.imageUrl,
    required this.price,
    required this.fixedPrice,
    required this.tags,
    required this.isActive,
    required this.createdAt,
    required this.id,
  });

  String boomType;
  String title;
  String boomState;
  bool isMinted;
  String description;
  String network;
  List<dynamic> comments;
  String user;
  String imageUrl;
  String price;
  String fixedPrice;
  List<String> tags;
  bool isActive;
  DateTime createdAt;
  String id;

  factory Boom.fromJson(Map<String, dynamic> json) => Boom(
        boomType: json["boom_type"],
        title: json["title"],
        boomState: json["boom_state"],
        isMinted: json["is_minted"],
        description: json["description"],
        network: json["network"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        user: json["user"],
        imageUrl: json["image_url"],
        price: json["price"],
        fixedPrice: json["fixed_price"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "boom_type": boomType,
        "title": title,
        "boom_state": boomState,
        "is_minted": isMinted,
        "description": description,
        "network": network,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "user": user,
        "image_url": imageUrl,
        "price": price,
        "fixed_price": fixedPrice,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class Page {
  Page();

  factory Page.fromJson(Map<String, dynamic> json) => Page();

  Map<String, dynamic> toJson() => {};
}
