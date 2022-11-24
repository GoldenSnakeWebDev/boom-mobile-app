// To parse this JSON data, do
//
//     final otherUserBooms = otherUserBoomsFromJson(jsonString);

import 'dart:convert';

import 'package:boom_mobile/models/network_model.dart';

OtherUserBooms otherUserBoomsFromJson(String str) =>
    OtherUserBooms.fromJson(json.decode(str));

String otherUserBoomsToJson(OtherUserBooms data) => json.encode(data.toJson());

class OtherUserBooms {
  OtherUserBooms({
    required this.status,
    required this.page,
    required this.booms,
  });

  String status;
  Page page;
  List<Boom> booms;

  factory OtherUserBooms.fromJson(Map<String, dynamic> json) => OtherUserBooms(
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
    required this.reactions,
    required this.boomType,
    required this.title,
    required this.boomState,
    required this.isMinted,
    required this.description,
    required this.location,
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

  Reactions reactions;
  String boomType;
  String title;
  String boomState;
  bool isMinted;
  String description;
  String location;
  Network network;
  List<Comment> comments;
  User user;
  String imageUrl;
  String price;
  String fixedPrice;
  List<String> tags;
  bool isActive;
  DateTime createdAt;
  String id;

  factory Boom.fromJson(Map<String, dynamic> json) => Boom(
        reactions: Reactions.fromJson(json["reactions"]),
        boomType: json["boom_type"],
        title: json["title"],
        boomState: json["boom_state"],
        isMinted: json["is_minted"],
        description: json["description"],
        location: json["location"],
        network: Network.fromJson(json["network"]),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        user: User.fromJson(json["user"]),
        imageUrl: json["image_url"],
        price: json["price"],
        fixedPrice: json["fixed_price"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "reactions": reactions.toJson(),
        "boom_type": boomType,
        "title": title,
        "boom_state": boomState,
        "is_minted": isMinted,
        "description": description,
        "location": location,
        "network": network.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "user": user.toJson(),
        "image_url": imageUrl,
        "price": price,
        "fixed_price": fixedPrice,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class Comment {
  Comment({
    required this.user,
    required this.boom,
    required this.message,
    required this.isActive,
    required this.createdAt,
    required this.id,
  });

  User user;
  String boom;
  String message;
  bool isActive;
  DateTime createdAt;
  String id;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: User.fromJson(json["user"]),
        boom: json["boom"],
        message: json["message"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "boom": boom,
        "message": message,
        "is_active": isActive,
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class User {
  User({
    required this.passwordReset,
    required this.socialMedia,
    required this.funs,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.photo,
    required this.cover,
    required this.email,
    required this.bio,
    required this.location,
    required this.userType,
    required this.booms,
    required this.isAdmin,
    required this.passwordResetToken,
    required this.syncBank,
    this.id,
  });

  PasswordReset passwordReset;
  SocialMedia socialMedia;
  List<dynamic> funs;
  String firstName;
  String lastName;
  String username;
  String photo;
  String cover;
  String email;
  String bio;
  String location;
  String userType;
  List<dynamic> booms;

  bool isAdmin;
  String passwordResetToken;
  String syncBank;
  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        passwordReset: PasswordReset.fromJson(json["password_reset"]),
        socialMedia: SocialMedia.fromJson(json["social_media"]),
        funs: List<dynamic>.from(json["funs"].map((x) => x)),
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        cover: json["cover"],
        email: json["email"],
        bio: json["bio"],
        location: json["location"],
        userType: json["user_type"],
        booms: List<dynamic>.from(json["booms"].map((x) => x)),
        isAdmin: json["is_admin"],
        passwordResetToken: json["password_reset_token"],
        syncBank: json["sync_bank"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "password_reset": passwordReset.toJson(),
        "social_media": socialMedia.toJson(),
        "funs": List<dynamic>.from(funs.map((x) => x)),
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "cover": cover,
        "email": email,
        "bio": bio,
        "location": location,
        "user_type": userType,
        "booms": List<dynamic>.from(booms.map((x) => x)),
        "is_admin": isAdmin,
        "password_reset_token": passwordResetToken,
        "sync_bank": syncBank,
        "id": id,
      };
}

class PasswordReset {
  PasswordReset({
    required this.isChanged,
  });

  bool isChanged;

  factory PasswordReset.fromJson(Map<String, dynamic> json) => PasswordReset(
        isChanged: json["is_changed"],
      );

  Map<String, dynamic> toJson() => {
        "is_changed": isChanged,
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

class Reactions {
  Reactions({
    required this.likes,
    required this.loves,
    required this.smiles,
    required this.rebooms,
    required this.reports,
  });

  List<User> likes;
  List<User> loves;
  List<User> smiles;
  List<User> rebooms;
  List<dynamic> reports;

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        likes: List<User>.from(json["likes"].map((x) => User.fromJson(x))),
        loves: List<User>.from(json["loves"].map((x) => User.fromJson(x))),
        smiles: List<User>.from(json["smiles"].map((x) => User.fromJson(x))),
        rebooms: List<User>.from(json["rebooms"].map((x) => User.fromJson(x))),
        reports: List<dynamic>.from(json["reports"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "loves": List<dynamic>.from(loves.map((x) => x.toJson())),
        "smiles": List<dynamic>.from(smiles.map((x) => x.toJson())),
        "rebooms": List<dynamic>.from(rebooms.map((x) => x.toJson())),
        "reports": List<dynamic>.from(reports.map((x) => x)),
      };
}

class Page {
  Page();

  factory Page.fromJson(Map<String, dynamic> json) => Page();

  Map<String, dynamic> toJson() => {};
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
