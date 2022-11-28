// To parse this JSON data, do
//
//     final allBooms = allBoomsFromJson(jsonString);

import 'dart:convert';

import 'package:boom_mobile/models/network_model.dart';

AllBooms allBoomsFromJson(String str) => AllBooms.fromJson(json.decode(str));

String allBoomsToJson(AllBooms data) => json.encode(data.toJson());

class AllBooms {
  AllBooms({
    this.status,
    this.booms,
  });

  String? status;

  List<Boom>? booms;

  factory AllBooms.fromJson(Map<String, dynamic> json) => AllBooms(
        status: json["status"],
        booms: List<Boom>.from(json["booms"].map((x) => Boom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "booms": List<dynamic>.from(booms!.map((x) => x.toJson())),
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

enum BoomState { UPLOAD }

final boomStateValues = EnumValues({"upload": BoomState.UPLOAD});

enum BoomType { IMAGE, TEXT }

final boomTypeValues =
    EnumValues({"image": BoomType.IMAGE, "text": BoomType.TEXT});

class Comment {
  Comment({
    this.user,
    this.boom,
    this.message,
    this.isActive,
    this.createdAt,
    this.id,
  });

  UserClass? user;
  String? boom;
  String? message;
  bool? isActive;
  DateTime? createdAt;
  String? id;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: UserClass.fromJson(json["user"]),
        boom: json["boom"],
        message: json["message"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "boom": boom,
        "message": message,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

class PasswordReset {
  PasswordReset({
    this.isChanged,
  });

  bool? isChanged;

  factory PasswordReset.fromJson(Map<String, dynamic> json) => PasswordReset(
        isChanged: json["is_changed"],
      );

  Map<String, dynamic> toJson() => {
        "is_changed": isChanged,
      };
}

class SocialMedia {
  SocialMedia({
    this.telegram,
    this.discord,
    this.medium,
    this.facebook,
    this.twitter,
    this.instagram,
    this.tiktok,
  });

  String? telegram;
  String? discord;
  String? medium;
  String? facebook;
  String? twitter;
  String? instagram;
  String? tiktok;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        telegram: json["telegram"],
        discord: json["discord"],
        medium: json["medium"],
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
      );

  Map<String, dynamic> toJson() => {
        "telegram": telegram,
        "discord": discord,
        "medium": medium,
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "tiktok": tiktok,
      };
}

class Reactions {
  Reactions({
    this.likes,
    this.loves,
    this.smiles,
    this.rebooms,
    this.reports,
  });

  List<UserClass>? likes;
  List<UserClass>? loves;
  List<UserClass>? smiles;
  List<UserClass>? rebooms;
  List<dynamic>? reports;

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        likes: List<UserClass>.from(
            json["likes"].map((x) => UserClass.fromJson(x))),
        loves: List<UserClass>.from(
            json["loves"].map((x) => UserClass.fromJson(x))),
        smiles: List<UserClass>.from(
            json["smiles"].map((x) => UserClass.fromJson(x))),
        rebooms: List<UserClass>.from(
            json["rebooms"].map((x) => UserClass.fromJson(x))),
        reports: List<dynamic>.from(json["reports"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
        "loves": List<dynamic>.from(loves!.map((x) => x.toJson())),
        "smiles": List<dynamic>.from(smiles!.map((x) => x.toJson())),
        "rebooms": List<dynamic>.from(rebooms!.map((x) => x.toJson())),
        "reports": List<dynamic>.from(reports!.map((x) => x)),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap;
    return reverseMap;
  }
}
