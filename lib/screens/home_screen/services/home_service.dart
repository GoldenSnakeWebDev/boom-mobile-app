import 'dart:convert';

import 'package:boom_mobile/utils/url_container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class HomeService {
  final box = GetStorage();

  fetchBooms(int page) async {
    String token = box.read("token");
    final res = await http.get(
      Uri.parse("${baseURL}booms/only-auth?page=$page"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token,
      },
    );
    return res;
  }

  reactToBoom(String reactionType, String boomId) async {
    String token = box.read("token");
    var d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(DateTime.now());
    Map<String, String> body = {
      "react_type": reactionType,
      "timestamp": d12,
    };
    final res = await http.patch(
      Uri.parse("${baseURL}react-to-booms/$boomId"),
      headers: {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "Authorization": token,
      },
      body: jsonEncode(body),
    );

    return res;
  }
}
