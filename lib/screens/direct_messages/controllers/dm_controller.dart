import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_box_response.dart';
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';

class DMCrontroller extends GetxController {
  final _service = DMService();

  IOWebSocketChannel? channel;

  List<BoomBox>? _boomBoxes;
  List<BoomBox>? get boomBoxes => _boomBoxes;

  var isLoading = false.obs;

  setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onInit() {
    fetchBoomBoxMessages();
    channel = IOWebSocketChannel.connect(
      'ws://170.16.2.44:4000',
    );
    super.onInit();
  }

  // @override
  // void onClose() {
  //   channel?.sink.close();
  //   super.onClose();
  // }

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
