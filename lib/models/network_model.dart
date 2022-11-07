// To parse this JSON data, do
//
//     final networkModel = networkModelFromJson(jsonString);

import 'dart:convert';

NetworkModel networkModelFromJson(String str) =>
    NetworkModel.fromJson(json.decode(str));

String networkModelToJson(NetworkModel data) => json.encode(data.toJson());

class NetworkModel {
  NetworkModel({
    required this.status,
    required this.page,
    required this.networks,
  });

  String status;
  Page page;
  List<Network> networks;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        status: json["status"],
        page: Page.fromJson(json["page"]),
        networks: List<Network>.from(
            json["networks"].map((x) => Network.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "page": page.toJson(),
        "networks": List<dynamic>.from(networks.map((x) => x.toJson())),
      };
}

class Network {
  Network({
    required this.name,
    required this.imageUrl,
    required this.symbol,
    required this.isActive,
    required this.id,
  });

  String name;
  String imageUrl;
  String symbol;
  bool isActive;
  String id;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        name: json["name"],
        imageUrl: json["image_url"],
        symbol: json["symbol"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image_url": imageUrl,
        "symbol": symbol,
        "is_active": isActive,
        "id": id,
      };
}

class Page {
  Page();

  factory Page.fromJson(Map<String, dynamic> json) => Page();

  Map<String, dynamic> toJson() => {};
}
