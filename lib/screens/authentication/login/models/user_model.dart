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
  });

  String status;
  User user;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        status: json["status"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.passwordReset,
    required this.socialMedia,
    required this.friends,
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
    // this.funs,
    required this.id,
  });

  PasswordReset passwordReset;
  SocialMedia socialMedia;
  List<dynamic> friends;
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
  SyncBank syncBank;
  // List<Fun>? funs;
  String id;

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
        isAdmin: json["is_admin"],
        passwordResetToken: json["password_reset_token"],
        syncBank: SyncBank.fromJson(json["sync_bank"]),
        // funs: List<Fun>.from(json["funs"].map((x) => Fun.fromJson(x))),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "password_reset": passwordReset.toJson(),
        "social_media": socialMedia.toJson(),
        "friends": List<dynamic>.from(friends.map((x) => x)),
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
        "sync_bank": syncBank.toJson(),
        // "funs": List<dynamic>.from(funs!.map((x) => x.toJson())),
        "id": id,
      };
}

class Fun {
  Fun({
    this.passwordReset,
    required this.socialMedia,
    required this.friends,
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
    required this.followers,
    required this.isAdmin,
    required this.passwordResetToken,
    required this.syncBank,
  });

  PasswordReset? passwordReset;
  SocialMedia socialMedia;
  List<dynamic> friends;
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
  List<dynamic> followers;
  bool isAdmin;
  String passwordResetToken;
  String syncBank;

  factory Fun.fromJson(Map<String, dynamic> json) => Fun(
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
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        isAdmin: json["is_admin"],
        passwordResetToken: json["password_reset_token"],
        syncBank: json["sync_bank"],
      );

  Map<String, dynamic> toJson() => {
        "password_reset": passwordReset?.toJson(),
        "social_media": socialMedia.toJson(),
        "friends": List<dynamic>.from(friends.map((x) => x)),
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
        "followers": List<dynamic>.from(followers.map((x) => x)),
        "is_admin": isAdmin,
        "password_reset_token": passwordResetToken,
        "sync_bank": syncBank,
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
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.tiktok,
  });

  String facebook;
  String twitter;
  String instagram;
  String tiktok;

  factory SocialMedia.fromJson(Map<String, dynamic> json) => SocialMedia(
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        tiktok: json["tiktok"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "tiktok": tiktok,
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
