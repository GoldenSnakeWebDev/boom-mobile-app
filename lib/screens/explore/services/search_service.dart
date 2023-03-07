import 'package:boom_mobile/utils/url_container.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class SearchService {
  final _storage = GetStorage();

  Future<dynamic> searchBooms(String query) async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };

    try {
      final response = await http.get(
        Uri.parse('${baseURL}searching?search=$query&page=all'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response;
      } else {
        EasyLoading.showError('Error searching');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }
}
