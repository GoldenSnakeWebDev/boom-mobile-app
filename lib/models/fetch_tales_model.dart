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
    required this.status,
    required this.page,
    required this.statuses,
  });

  String status;
  Page page;
  List<UserStatus> statuses;

  factory FetchStatusModel.fromJson(Map<String, dynamic> json) =>
      FetchStatusModel(
        status: json["status"],
        page: Page.fromJson(json["page"]),
        statuses: List<UserStatus>.from(
            json["statuses"].map((x) => UserStatus.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "page": page.toJson(),
        "statuses": List<Status>.from(statuses.map((x) => x.toJson())),
      };
}

class Page {
  Page();

  factory Page.fromJson(Map<String, dynamic> json) => Page();

  Map<String, dynamic> toJson() => {};
}

class UserStatus {
  UserStatus({
    required this.id,
    required this.count,
    required this.statues,
  });

  Id id;
  int count;
  List<Status> statues;

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        id: Id.fromJson(json["_id"]),
        count: json["count"],
        statues:
            List<Status>.from(json["statues"].map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "count": count,
        "statues": List<dynamic>.from(statues.map((x) => x.toJson())),
      };
}

class Id {
  Id({
    required this.username,
    required this.id,
    required this.photo,
  });

  String username;
  String id;
  String photo;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        username: json["username"],
        id: json["id"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "id": id,
        "photo": photo,
      };
}

class Status {
  Status({
    required this.id,
    required this.imageUrl,
    required this.views,
  });

  String id;
  String imageUrl;
  List<dynamic> views;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        imageUrl: json["image_url"],
        views: List<dynamic>.from(json["views"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "views": List<dynamic>.from(views.map((x) => x)),
      };
}
