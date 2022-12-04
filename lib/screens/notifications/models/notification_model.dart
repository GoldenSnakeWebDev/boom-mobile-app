// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.status,
    this.notifications,
  });

  String? status;

  List<Notification>? notifications;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        status: json["status"],
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "notifications":
            List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notification {
  Notification({
    this.user,
    this.boom,
    this.notificationType,
    this.message,
    this.isRead,
    this.id,
    this.timestamp,
  });

  User? user;
  Boom? boom;
  String? notificationType;
  String? message;
  bool? isRead;
  String? id;
  DateTime? timestamp;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        user: User.fromJson(json["user"]),
        boom: json["boom"] == null ? null : Boom.fromJson(json["boom"]),
        notificationType: json["notification_type"],
        message: json["message"],
        isRead: json["is_read"],
        id: json["id"],
        timestamp: DateTime.parse(json["timestamp"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "boom": boom == null ? null : boom?.toJson(),
        "notification_type": notificationType,
        "message": message,
        "is_read": isRead,
        "id": id,
        "timestamp": timestamp?.toIso8601String(),
      };
}

class Boom {
  Boom({
    this.title,
    this.price,
    this.id,
  });

  String? title;
  String? price;
  String? id;

  factory Boom.fromJson(Map<String, dynamic> json) => Boom(
        title: json["title"],
        price: json["price"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "id": id,
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
