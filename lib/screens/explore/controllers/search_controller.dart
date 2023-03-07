import 'dart:convert';

import 'package:boom_mobile/screens/explore/models/search_result_model.dart';
import 'package:boom_mobile/screens/explore/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final _service = SearchService();

  TextEditingController searchFormController = TextEditingController();

  SearchResults? _searchResults;
  SearchResults? get searchResults => _searchResults;

  var isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  searchBooms() async {
    final query = searchFormController.text;
    if (query.isNotEmpty) {
      setLoading(true);

      final res = await _service.searchBooms(query);
      _searchResults = SearchResults.fromJson(jsonDecode(res.body));

      setLoading(false);
    } else {
      _searchResults = null;
    }
  }
}
