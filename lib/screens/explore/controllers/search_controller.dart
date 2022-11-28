import 'package:boom_mobile/screens/explore/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_screen/models/all_booms.dart';

class SearchController extends GetxController {
  final _service = SearchService();

  TextEditingController searchFormController = TextEditingController();

  List<Boom>? _searchedBooms;
  List<Boom>? get searchBoomResults => _searchedBooms;
  var isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  searchBooms() async {
    final query = searchFormController.text;
    if (query.isNotEmpty) {
      setLoading(true);
      final res = await _service.searchBooms(query);
      setLoading(false);
      _searchedBooms = res;
    } else {
      _searchedBooms = null;
    }
  }
}
