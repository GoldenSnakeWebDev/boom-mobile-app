// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.user,
  });

  String? status;
  User? user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user?.toJson(),
      };
}

class User {
  User({
    this.passwordReset,
    this.socialMedia,
    this.friends,
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
    this.isAdmin,
    this.passwordResetToken,
    this.syncBank,
    this.funs,
    this.id,
  });

  PasswordReset? passwordReset;
  SocialMedia? socialMedia;
  List<dynamic>? friends;
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
  List<String>? followers;
  bool? isAdmin;
  String? passwordResetToken;
  SyncBank? syncBank;
  List<Fun>? funs;
  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        passwordReset: PasswordReset.fromJson(json["password_reset"]),
        socialMedia: SocialMedia.fromJson(json["social_media"]),
        friends: List<dynamic>.from(json["friends"].map((x) => x)),
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
        followers: List<String>.from(json["followers"].map((x) => x)),
        isAdmin: json["is_admin"],
        passwordResetToken: json["password_reset_token"],
        syncBank: SyncBank.fromJson(json["sync_bank"]),
        funs: List<Fun>.from(json["funs"].map((x) => Fun.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "password_reset": passwordReset?.toJson(),
        "social_media": socialMedia?.toJson(),
        "friends": List<dynamic>.from(friends!.map((x) => x)),
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
        "is_admin": isAdmin,
        "password_reset_token": passwordResetToken,
        "sync_bank": syncBank?.toJson(),
        "funs": List<dynamic>.from(funs!.map((x) => x.toJson())),
        "id": id,
      };
}

class Fun {
  Fun({
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

  factory Fun.fromJson(Map<String, dynamic> json) => Fun(
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        id: json["id"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "id": id ?? null,
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

class SyncBank {
  SyncBank({
    this.tezos,
    this.binance,
    this.polygon,
    this.syncId,
    this.user,
    this.syncBankType,
    this.isActive,
    this.id,
  });

  Crypto? tezos;
  Crypto? binance;
  Crypto? polygon;
  String? syncId;
  String? user;
  String? syncBankType;
  bool? isActive;
  String? id;

  factory SyncBank.fromJson(Map<String, dynamic> json) => SyncBank(
        tezos: Crypto.fromJson(json["tezos"]),
        binance: Crypto.fromJson(json["binance"]),
        polygon: Crypto.fromJson(json["polygon"]),
        syncId: json["syncID"],
        user: json["user"],
        syncBankType: json["sync_bank_type"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "tezos": tezos!.toJson(),
        "binance": binance!.toJson(),
        "polygon": polygon!.toJson(),
        "syncID": syncId,
        "user": user,
        "sync_bank_type": syncBankType,
        "is_active": isActive,
        "id": id,
      };
}

class Crypto {
  Crypto({
    this.amountIn,
    this.amountOut,
    this.amountBalance,
  });

  double? amountIn;
  double? amountOut;
  double? amountBalance;

  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
        amountIn: double.parse(json["amount_in"].toString()),
        amountOut: double.parse(json["amount_out"].toString()),
        amountBalance: double.parse(json["amount_balance"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "amount_in": amountIn,
        "amount_out": amountOut,
        "amount_balance": amountBalance,
      };
}
