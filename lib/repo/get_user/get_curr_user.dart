import 'package:boom_mobile/utils/url_container.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FetchCurrUserRepo extends GetConnect {
  Future fetchCurrUser(String token) async {
    final res = await http.get(
      Uri.parse("${baseURL}users/currentUser"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    return res;
  }
}
