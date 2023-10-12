import 'package:boom_mobile/screens/direct_messages/service/messages_service.dart';
import 'package:get/get.dart';

class SingleMsgController extends GetxController {
  DMService service = DMService();

  @override
  void onInit() {
    service.fetchMessages(Get.arguments);
    super.onInit();
  }
}
