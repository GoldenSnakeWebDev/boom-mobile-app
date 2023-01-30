import 'package:boom_mobile/screens/direct_messages/models/boom_box_response.dart';
import 'package:boom_mobile/screens/direct_messages/models/messages_model.dart';
import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:web_socket_channel/io.dart';

import '../models/boom_users_model.dart';

class DMCrontroller extends GetxController {
  final service = DMService();
  final _storage = GetStorage();

  IOWebSocketChannel? channel;

  List<BoomBox>? _boomBoxes;
  List<BoomBox>? get boomBoxes => _boomBoxes;

  List<User>? _boxUsers;
  List<User>? get boxUsers => _boxUsers;

  List<DMMessage>? _dmMessages;
  List<DMMessage>? get dmMessages => _dmMessages;

  var isLoading = false.obs;

  String boomBox = '';

  setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onInit() {
    fetchBoomBoxMessages();
    fetchUsers();
    channel = IOWebSocketChannel.connect(
      'ws://170.16.2.44:4000',
    );
    super.onInit();
  }

  // Fetch boom box messages
  Future<dynamic> fetchBoomBoxMessages() async {
    setLoading(true);
    var ress = await service.fetchBoomBoxMessages();
    setLoading(false);
    if (ress != null) {
      _boomBoxes = [...ress];
      update();
    }
  }

  Future<dynamic> fetchUsers() async {
    var ress = await service.fetchUsers();
    if (ress != null) {
      _boxUsers = [...ress];
      update();
    }
  }

  // Future<dynamic> fetchDMs(String boomId) async {
  //   var ress = await service.fetchDMs(boomId);
  //   if (ress != null) {
  //     _dmMessages = ress.messages;
  //     update();
  //     return true;
  //   }
  // }

  chatWithUser(
    String command,
    String? content,
    String? receiver,
    String? box,
  ) async {
    setLoading(true);
    var ress = await service.chatWithUser(
      {
        "command": command,
        "content": "$content",
        "author": "${_storage.read('userId')}",
        "receiver": "$receiver",
        "box": "$box",
        "timestamp": DateTime.now().millisecondsSinceEpoch,
      },
    );
    setLoading(false);
    if (ress != null) {
      fetchBoomBoxMessages();
      boomBox = ress;
    }
    return ress;
  }
}
