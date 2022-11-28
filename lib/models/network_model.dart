// To parse this JSON data, do
//
//     final networkModel = networkModelFromJson(jsonString);

import 'dart:convert';

NetworkModel networkModelFromJson(String str) =>
    NetworkModel.fromJson(json.decode(str));

String networkModelToJson(NetworkModel data) => json.encode(data.toJson());

class NetworkModel {
  NetworkModel({
    this.status,
    this.networks,
  });

  String? status;

  List<Network>? networks;

  factory NetworkModel.fromJson(Map<String, dynamic> json) => NetworkModel(
        status: json["status"],
        networks: List<Network>.from(
            json["networks"].map((x) => Network.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "networks": List<dynamic>.from(networks!.map((x) => x.toJson())),
      };
}

class Network {
  Network({
    this.price,
    this.name,
    this.imageUrl,
    this.symbol,
    this.isActive,
    this.id,
  });

  double? price;
  String? name;
  String? imageUrl;
  String? symbol;
  bool? isActive;
  String? id;

  factory Network.fromJson(Map<String, dynamic> json) => Network(
        price: double.parse(json["price"].toString()),
        name: json["name"],
        imageUrl: json["image_url"],
        symbol: json["symbol"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "name": name,
        "image_url": imageUrl,
        "symbol": symbol,
        "is_active": isActive,
        "id": id,
      };
}
