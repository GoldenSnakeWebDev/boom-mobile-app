// To parse this JSON data, do
//
//     final singleBoom = singleBoomFromJson(jsonString);

import 'dart:convert';

SingleBoom singleBoomFromJson(String str) =>
    SingleBoom.fromJson(json.decode(str));

String singleBoomToJson(SingleBoom data) => json.encode(data.toJson());

class SingleBoom {
  SingleBoom({
    required this.status,
    required this.boom,
  });

  String status;
  Boom boom;

  factory SingleBoom.fromJson(Map<String, dynamic> json) => SingleBoom(
        status: json["status"],
        boom: Boom.fromJson(json["boom"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "boom": boom.toJson(),
      };
}

class Boom {
  Boom({
    this.reactions,
    this.boomType,
    this.title,
    this.boomState,
    this.isMinted,
    this.description,
    this.location,
    this.network,
    this.comments,
    this.user,
    this.imageUrl,
    this.price,
    this.fixedPrice,
    this.tags,
    this.isActive,
    this.createdAt,
    this.id,
  });

  Reactions? reactions;
  String? boomType;
  String? title;
  BoomState? boomState;
  bool? isMinted;
  String? description;
  String? location;
  Network? network;
  List<Comment>? comments;
  UserClass? user;
  String? imageUrl;
  String? price;
  String? fixedPrice;
  List<String>? tags;
  bool? isActive;
  DateTime? createdAt;
  String? id;

  factory Boom.fromJson(Map<String, dynamic> json) => Boom(
        reactions: Reactions.fromJson(json["reactions"]),
        boomType: json["boom_type"],
        title: json["title"],
        boomState: boomStateValues.map[json["boom_state"]],
        isMinted: json["is_minted"],
        description: json["description"],
        location: json["location"],
        network: Network.fromJson(json["network"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        user: UserClass.fromJson(json["user"]),
        imageUrl: json["image_url"],
        price: json["price"],
        fixedPrice: json["fixed_price"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "reactions": reactions?.toJson(),
        "boom_type": boomTypeValues.reverse[boomType],
        "title": title,
        "boom_state": boomStateValues.reverse[boomState],
        "is_minted": isMinted,
        "description": description,
        "location": location,
        "network": network?.toJson(),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "image_url": imageUrl,
        "price": price,
        "fixed_price": fixedPrice,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

enum BoomState {
  UPLOAD,
  SYNTHETIC,
  REAL_NFT,
}

final boomStateValues = EnumValues({
  "upload": BoomState.UPLOAD,
  "realnft": BoomState.REAL_NFT,
  "synthetic": BoomState.SYNTHETIC
});

enum BoomType {
  IMAGE,
  TEXT,
  VIDEO,
}

final boomTypeValues = EnumValues({
  "image": BoomType.IMAGE,
  "text": BoomType.TEXT,
  "video": BoomType.VIDEO,
});

class Comment {
  Comment({
    required this.user,
    required this.boom,
    required this.message,
    required this.isActive,
    required this.createdAt,
    required this.id,
  });

  UserClass user;
  String boom;
  String message;
  bool isActive;
  DateTime createdAt;
  String id;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: UserClass.fromJson(json["user"]),
        boom: json["boom"],
        message: json["message"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "boom": boom,
        "message": message,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class Network {
  Network({
    required this.name,
    required this.imageUrl,
    required this.symbol,
    required this.isActive,
    required this.id,
  });

  String name;
  String imageUrl;
  String symbol;
  bool isActive;
  String id;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        name: json["name"],
        imageUrl: json["image_url"],
        symbol: json["symbol"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
        "symbol": symbol,
        "is_active": isActive,
        "id": id,
      };
}

class Reactions {
  Reactions({
    required this.likes,
    required this.loves,
    required this.smiles,
    required this.rebooms,
    required this.reports,
  });

  List<UserClass> likes;
  List<UserClass> loves;
  List<UserClass> smiles;
  List<UserClass> rebooms;
  List<UserClass> reports;

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        likes: List<UserClass>.from(
            json["likes"].map((x) => UserClass.fromJson(x))),
        loves: List<UserClass>.from(
            json["loves"].map((x) => UserClass.fromJson(x))),
        smiles: List<UserClass>.from(
            json["smiles"].map((x) => UserClass.fromJson(x))),
        rebooms: List<UserClass>.from(
            json["rebooms"].map((x) => UserClass.fromJson(x))),
        reports: List<UserClass>.from(
            json["reports"].map((x) => UserClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "loves": List<dynamic>.from(loves.map((x) => x.toJson())),
        "smiles": List<dynamic>.from(smiles.map((x) => x.toJson())),
        "rebooms": List<dynamic>.from(rebooms.map((x) => x.toJson())),
        "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
      };
}

class UserClass {
  UserClass({
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

  factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
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

class SocialMedia {
  SocialMedia({
    required this.twitter,
    required this.instagram,
    required this.tiktok,
    required this.facebook,
  });

  String twitter;
  String instagram;
  String tiktok;
  String facebook;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        twitter: json["twitter"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
        facebook: json["facebook"],
      );

  Map<String, dynamic> toJson() => {
        "twitter": twitter,
        "instagram": instagram,
        "tiktok": tiktok,
        "facebook": facebook,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
