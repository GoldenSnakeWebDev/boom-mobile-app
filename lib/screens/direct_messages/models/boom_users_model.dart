//     final boomUsers = boomUsersFromJson(jsonString);

import 'dart:convert';

BoomUsers boomUsersFromJson(String str) => BoomUsers.fromJson(json.decode(str));

String boomUsersToJson(BoomUsers data) => json.encode(data.toJson());

class BoomUsers {
  BoomUsers({
    this.status,
    this.users,
  });

  String? status;
  List<User>? users;

  factory BoomUsers.fromJson(Map<String, dynamic> json) => BoomUsers(
        status: json["status"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "users": List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.photo,
    this.userId,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? username;
  String? photo;
  String? userId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        photo: json["photo"],
        userId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "photo": photo,
        "id": userId,
      };
}
