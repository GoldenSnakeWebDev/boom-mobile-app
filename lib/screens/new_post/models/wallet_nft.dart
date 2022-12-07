// To parse this JSON data, do
//
//     final walletNft = walletNftFromJson(jsonString);

import 'dart:convert';

WalletNft walletNftFromJson(String str) => WalletNft.fromJson(json.decode(str));

String walletNftToJson(WalletNft data) => json.encode(data.toJson());

class WalletNft {
  WalletNft({
    required this.name,
    required this.description,
    required this.image,
  });

  String name;
  String description;
  String image;

  factory WalletNft.fromJson(Map<String, dynamic> json) => WalletNft(
        name: json["name"],
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "image": image,
      };
}
