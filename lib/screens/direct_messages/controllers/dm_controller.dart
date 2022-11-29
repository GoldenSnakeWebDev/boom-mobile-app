import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_box_response.dart';
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class DMCrontroller extends GetxController {
  final _service = DMService();

  final IOWebSocketChannel channel = IOWebSocketChannel.connect(
    'ws://170.16.2.44:4000',
  );

  List<BoomBox>? _boomBoxes;
  List<BoomBox>? get boomBoxes => _boomBoxes;

  var isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onInit() {
    fetchBoomBoxMessages();
    super.onInit();
  }

  @override
  void onReady() {
    log('DMCrontroller onReady');
    super.onReady();
  }

  @override
  void onClose() {}

  // Fetch boom box messages
  Future<dynamic> fetchBoomBoxMessages() async {
    setLoading(true);
    var ress = await _service.fetchBoomBoxMessages();
    setLoading(false);
    if (ress != null) {
      _boomBoxes = [...ress];
      update();
    }
  }
}
