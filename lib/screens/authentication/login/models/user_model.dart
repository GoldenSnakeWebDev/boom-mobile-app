// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.status,
    required this.user,
    required this.token,
    required this.cookie,
    required this.message,
  });

  String status;
  User user;
  String token;
  String cookie;
  String message;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        user: User.fromJson(json["user"]),
        token: json["token"],
        cookie: json["cookie"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
        "token": token,
        "cookie": cookie,
        "message": message,
      };
}

class User {
  User({
    required this.passwordReset,
    required this.socialMedia,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.photo,
    required this.email,
    required this.bio,
    required this.location,
    required this.userType,
    required this.booms,
    required this.followers,
    required this.following,
    required this.isAdmin,
    required this.passwordResetToken,
    required this.syncBank,
    required this.id,
  });

  PasswordReset passwordReset;
  SocialMedia socialMedia;
  String firstName;
  String lastName;
  String username;
  String photo;
  String email;
  String bio;
  String location;
  String userType;
  List<dynamic> booms;
  List<dynamic> followers;
  List<dynamic> following;
  bool isAdmin;
  String passwordResetToken;
  SyncBank syncBank;
  String id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        passwordReset: PasswordReset.fromJson(json["password_reset"]),
        socialMedia: SocialMedia.fromJson(json["social_media"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        email: json["email"],
        bio: json["bio"],
        location: json["location"],
        userType: json["user_type"],
        booms: List<dynamic>.from(json["booms"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        isAdmin: json["is_admin"],
        passwordResetToken: json["password_reset_token"],
        syncBank: SyncBank.fromJson(json["sync_bank"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "password_reset": passwordReset.toJson(),
        "social_media": socialMedia.toJson(),
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "email": email,
        "bio": bio,
        "location": location,
        "user_type": userType,
        "booms": List<dynamic>.from(booms.map((x) => x)),
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "following": List<dynamic>.from(following.map((x) => x)),
        "is_admin": isAdmin,
        "password_reset_token": passwordResetToken,
        "sync_bank": syncBank.toJson(),
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

class SyncBank {
  SyncBank({
    required this.syncId,
    required this.amountIn,
    required this.amountOut,
    required this.amountBalance,
    required this.user,
    required this.syncBankType,
    required this.isActive,
    required this.id,
  });

  String syncId;
  int amountIn;
  int amountOut;
  int amountBalance;
  String user;
  String syncBankType;
  bool isActive;
  String id;

  factory SyncBank.fromJson(Map<String, dynamic> json) => SyncBank(
        syncId: json["syncID"],
        amountIn: json["amount_in"],
        amountOut: json["amount_out"],
        amountBalance: json["amount_balance"],
        user: json["user"],
        syncBankType: json["sync_bank_type"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "syncID": syncId,
        "amount_in": amountIn,
        "amount_out": amountOut,
        "amount_balance": amountBalance,
        "user": user,
        "sync_bank_type": syncBankType,
        "is_active": isActive,
        "id": id,
      };
}
