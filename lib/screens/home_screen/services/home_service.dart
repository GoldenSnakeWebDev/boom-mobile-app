import 'package:boom_mobile/utils/url_container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class HomeService {
  final box = GetStorage();

  fetchBooms() async {
    String token = box.read("token");
    final res = await http.get(
      Uri.parse("${baseURL}booms?page=all"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token,
      },
    );
    return res;
  }
}
