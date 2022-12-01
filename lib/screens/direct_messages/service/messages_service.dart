import 'dart:convert';
import 'dart:developer';

import 'package:boom_mobile/screens/direct_messages/models/boom_box_response.dart';
import 'package:boom_mobile/screens/direct_messages/models/boom_users_model.dart';
import 'package:boom_mobile/screens/direct_messages/models/messages_model.dart';
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
        Uri.parse('${baseURL}boom-boxes'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final boomResponse = boomResponseFromJson(response.body);
        return boomResponse.boomBox;
      } else {
        EasyLoading.showError('Error boom-boxes');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }

  Stream<DMBoomBox?> fetchDMs(String boomId) async* {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    log('boomId: $boomId');
    try {
      final response = await http.get(
        Uri.parse('${baseURL}boom-boxes/$boomId/messages'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        log("get-dmssss >>>> ${response.body}");
        final dMsResponse = dMsResponseFromJson(response.body);
        yield dMsResponse.boomBox;
      } else {
        EasyLoading.showError('Error gettting dms');
        yield null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      yield null;
    }
  }

  Future<dynamic> fetchUsers() async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    try {
      final response = await http.get(
        Uri.parse('${baseURL}users'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final boomUsers = boomUsersFromJson(response.body);
        return boomUsers.users;
      } else {
        EasyLoading.showError('Error boom-boxes');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }

  Future<dynamic> chatWithUser(Map<String, dynamic> boomBoxData) async {
    var token = _storage.read('token');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': '$token',
    };
    log('boomBoxData: $boomBoxData');
    try {
      final response = await http.post(
        Uri.parse('${baseURL}boom-box'),
        headers: headers,
        body: jsonEncode(boomBoxData),
      );
      log("chatWithUser response :: ${response.body}");
      log("chatWithUser code :: ${response.statusCode}");
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError('Error sending boom-box');
        return null;
      }
    } catch (e) {
      EasyLoading.showError('Error: $e');
      return null;
    }
  }
}
