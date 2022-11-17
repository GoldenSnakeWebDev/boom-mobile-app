import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/models/fetch_tales_model.dart';
import 'package:boom_mobile/models/post_status_model.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class TalesService {
  final _storage = GetStorage();

  // fetch tales
  Future<dynamic> fetchTales() async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.get(
        Uri.parse('${baseURL}statuses?page=all'),
        headers: headers,
      );
      log("tales response ::: ${response.body}");
      if (response.statusCode == 200) {
        final fetchStatusModel = fetchStatusModelFromJson(response.body);

        return fetchStatusModel.statuses;
      } else {
        EasyLoading.showError('Error fetching tales');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error fetching tales');
      return null;
    }
  }

  Future<dynamic> postTale(String imageUrl) async {
    EasyLoading.show(status: 'Posting tale...');
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.post(
        Uri.parse('${baseURL}statuses'),
        headers: headers,
        body: jsonEncode({
          "status_type": "tale",
          "image_url": imageUrl,
        }),
      );
      log('Post tale response >> ${response.body}');
      if (response.statusCode == 201) {
        final postStatusModel = postStatusModelFromJson(response.body);
        EasyLoading.showSuccess("${postStatusModel.message}");
        return postStatusModel.statusData;
      } else {
        EasyLoading.showError('Error posting tale');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error posting tale');
      return null;
    }
  }
}
