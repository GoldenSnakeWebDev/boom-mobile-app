import 'package:boom_mobile/screens/direct_messages/models/boom_box_response.dart';
import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class DMService {
  final _storage = GetStorage();

  Future<dynamic> fetchBoomBoxMessages() async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.get(
        Uri.parse('${baseURL}boom-boxes?page=all'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final dmResponse = dmResponseFromJson(response.body);
        return dmResponse.boomBoxes;
      } else {
        EasyLoading.showError('Error boom-boxes');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }
}
