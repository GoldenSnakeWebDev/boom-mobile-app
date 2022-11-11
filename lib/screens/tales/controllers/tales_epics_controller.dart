import 'dart:developer';

import 'package:boom_mobile/models/fetch_status_model.dart';
import 'package:boom_mobile/screens/tales/services/tales_service.dart';
import 'package:get/get.dart';

class TalesEpicsController extends GetxController {
  final _talesService = TalesService();

  List<Status>? _tales;
  List<Status>? get tales => _tales;

  var isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onInit() async {
    fetchTales();
    update();
    super.onInit();
  }

  // fetchTales
  Future<dynamic> fetchTales() async {
    setLoading(true);
    var talesRess = await _talesService.fetchTales();
    log("talesRess ::: $talesRess");
    setLoading(false);
    if (talesRess != null) {
      _tales = [...talesRess];
      update();
    }
  }

  // postTale
  Future<dynamic> postTale(String imageUrl) async {
    setLoading(true);
    var postTaleRess = await _talesService.postTale(imageUrl);
    setLoading(false);
    if (postTaleRess != null) {
      _tales?.insert(0, postTaleRess);
      update();
    }
  }
}
