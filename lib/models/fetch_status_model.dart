// To parse this JSON data, do
//
//     final fetchStatusModel = fetchStatusModelFromJson(jsonString);

import 'dart:convert';

FetchStatusModel fetchStatusModelFromJson(String str) =>
    FetchStatusModel.fromJson(json.decode(str));

String fetchStatusModelToJson(FetchStatusModel data) =>
    json.encode(data.toJson());

class FetchStatusModel {
  FetchStatusModel({
    this.status,
    this.page,
    this.statuses,
  });

  String? status;
  Page? page;
  List<Status>? statuses;

  factory FetchStatusModel.fromJson(Map<String, dynamic> json) =>
      FetchStatusModel(
        status: json["status"],
        page: Page.fromJson(json["page"]),
        statuses:
            List<Status>.from(json["statuses"].map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "page": page?.toJson(),
        "statuses": List<dynamic>.from(statuses!.map((x) => x.toJson())),
      };
}

class Page {
  Page();

  factory Page.fromJson(Map<String, dynamic> json) => Page();

  Map<String, dynamic> toJson() => {};
}

class Status {
  Status({
    this.statusType,
    this.user,
    this.imageUrl,
    this.expiryTime,
    this.isActive,
    this.createdAt,
    this.id,
  });

  String? statusType;
  User? user;
  String? imageUrl;
  String? expiryTime;
  bool? isActive;
  DateTime? createdAt;
  String? id;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        statusType: json["status_type"],
        user: User.fromJson(json["user"]),
        imageUrl: json["image_url"],
        expiryTime: json["expiry_time"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status_type": statusType,
        "user": user?.toJson(),
        "image_url": imageUrl,
        "expiry_time": expiryTime,
        "is_active": isActive,
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}

class User {
  User({
    this.passwordReset,
    this.socialMedia,
    this.funs,
    this.firstName,
    this.lastName,
    this.username,
    this.photo,
    this.cover,
    this.email,
    this.bio,
    this.location,
    this.userType,
    this.booms,
    this.followers,
    this.following,
    this.isAdmin,
    this.passwordResetToken,
    this.syncBank,
    this.id,
  });

  PasswordReset? passwordReset;
  SocialMedia? socialMedia;
  List<dynamic>? funs;
  String? firstName;
  String? lastName;
  String? username;
  String? photo;
  String? cover;
  String? email;
  String? bio;
  String? location;
  String? userType;
  List<dynamic>? booms;
  List<dynamic>? followers;
  List<dynamic>? following;
  bool? isAdmin;
  String? passwordResetToken;
  String? syncBank;
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
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        isAdmin: json["is_admin"],
        passwordResetToken: json["password_reset_token"],
        syncBank: json["sync_bank"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "password_reset": passwordReset?.toJson(),
        "social_media": socialMedia?.toJson(),
        "funs": List<dynamic>.from(funs!.map((x) => x)),
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "cover": cover,
        "email": email,
        "bio": bio,
        "location": location,
        "user_type": userType,
        "booms": List<dynamic>.from(booms!.map((x) => x)),
        "followers": List<dynamic>.from(followers!.map((x) => x)),
        "following": List<dynamic>.from(following!.map((x) => x)),
        "is_admin": isAdmin,
        "password_reset_token": passwordResetToken,
        "sync_bank": syncBank,
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
    this.twitter,
    this.instagram,
    this.tiktok,
    this.facebook,
  });

  String? twitter;
  String? instagram;
  String? tiktok;
  String? facebook;

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
