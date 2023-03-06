// To parse this JSON data, do
//
//     final stripeProducts = stripeProductsFromJson(jsonString);

import 'dart:convert';

StripeProducts stripeProductsFromJson(String str) =>
    StripeProducts.fromJson(json.decode(str));

String stripeProductsToJson(StripeProducts data) => json.encode(data.toJson());

class StripeProducts {
  StripeProducts({
    required this.products,
    required this.status,
  });

  List<Product> products;
  String status;

  factory StripeProducts.fromJson(Map<String, dynamic> json) => StripeProducts(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "status": status,
      };
}

class Product {
  Product({
    required this.name,
    required this.priceInCents,
    required this.description,
    required this.isActive,
    required this.id,
  });

  String name;
  int priceInCents;
  String description;
  bool isActive;
  String id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        priceInCents: json["price_in_cents"],
        description: json["description"],
        isActive: json["is_active"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price_in_cents": priceInCents,
        "description": description,
        "is_active": isActive,
        "id": id,
      };
}
