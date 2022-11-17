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
  List<UserStatus>? statuses;

  factory FetchStatusModel.fromJson(Map<String, dynamic> json) =>
      FetchStatusModel(
        status: json["status"],
        page: Page.fromJson(json["page"]),
        statuses: List<UserStatus>.from(
            json["statuses"].map((x) => UserStatus.fromJson(x))),
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

class UserStatus {
  UserStatus({
    this.id,
    this.count,
    this.statues,
  });

  String? id;
  int? count;
  List<Statue>? statues;

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        id: json["_id"],
        count: json["count"],
        statues:
            List<Statue>.from(json["statues"].map((x) => Statue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "count": count,
        "statues": List<dynamic>.from(statues!.map((x) => x.toJson())),
      };
}

class Statue {
  Statue({
    this.id,
    this.imageUrl,
  });

  String? id;
  String? imageUrl;

  factory Statue.fromJson(Map<String, dynamic> json) => Statue(
        id: json["id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}
