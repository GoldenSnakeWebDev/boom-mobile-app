import 'package:boom_mobile/screens/explore/services/search_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_screen/models/all_booms.dart';

class SearchController extends GetxController {
  final _service = SearchService();

  TextEditingController searchFormController = TextEditingController();
  var isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  Future<List<Boom>> searchBooms() async {
    final query = searchFormController.text;
    setLoading(true);
    final res = await _service.searchBooms(query);
    setLoading(false);
    if (res != null) {
      return res;
    } else {
      return [];
    }
  }
}
