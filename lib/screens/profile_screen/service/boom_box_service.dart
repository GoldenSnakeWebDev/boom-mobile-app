import 'package:boom_mobile/utils/url_container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class BoomBoxService {
  final box = GetStorage();

  fetchUserBoomBox() async {
    final token = box.read("token");
    final res = await http.get(
      Uri.parse("${baseURL}boom-box"),
      headers: {
        "Authorization": token,
      },
    );

    return res;
  }

  sendMessage() async {}

  fetchBoxMessages() async* {}
}
