// To parse this JSON data, do
//
//     final searchResults = searchResultsFromJson(jsonString);

import 'dart:convert';

import 'package:boom_mobile/screens/home_screen/models/all_booms.dart';

SearchResults searchResultsFromJson(String str) =>
    SearchResults.fromJson(json.decode(str));

String searchResultsToJson(SearchResults data) => json.encode(data.toJson());

class SearchResults {
  SearchResults({
    required this.status,
    required this.search,
  });

  String status;

  Search search;

  factory SearchResults.fromJson(Map<String, dynamic> json) => SearchResults(
        status: json["status"],
        search: Search.fromJson(json["search"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "search": search.toJson(),
      };
}

class Search {
  Search({
    required this.booms,
    required this.accounts,
  });

  List<Boom> booms;
  List<UserClass> accounts;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        booms: List<Boom>.from(json["booms"].map((x) => Boom.fromJson(x))),
        accounts: List<UserClass>.from(
            json["accounts"].map((x) => UserClass.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "booms": List<dynamic>.from(booms.map((x) => x.toJson())),
        "accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
      };
}
