import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/new_post/models/new_post_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class UploadService {
  final box = GetStorage();
  Future<dynamic> uploadPost(NewPostModel boom) async {
    String token = box.read("token");
    final Map<String, dynamic> body = {
      "boom_type": boom.boomType,
      "network": boom.network,
      "description": boom.description,
      "image_url": boom.imageUrl,
      "title": boom.title,
      "quantity": boom.quantity,
      "tags": boom.tags,
      "fixed_price": boom.fixedPrice,
      "price": boom.price,
      "location": boom.location,
      "timestamp": boom.timestamp
    };
    log("Body $token");
    final res = http.post(
      Uri.parse("${baseURL}booms"),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": token,
      },
      body: jsonEncode(body),
    );

    return res;
  }

  getNetWorks() async {}
}
