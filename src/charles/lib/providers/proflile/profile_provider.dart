import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexabyte/utils/utils.dart';

import 'package:http/http.dart' as http;

class ProfileProvider {
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> getProfileData() async {
    print('doing');
    final token = await storage.read(key: 'token');
    print(token);

    final response = await http.get(
      Uri.parse(Utils.backendUrl! + '/api/user'),
      headers: {
        ...Utils.headerValue,
        'auth-token': token!,
      },
    );
    print('here');
    print(json.decode(response.body));

    return json.decode(response.body);
  }

  Future<void> updateUserData(Map<String, dynamic> data, dynamic userId) async {
    final token = await storage.read(key: 'token');
    print(token);

    final response = await http.put(
      Uri.parse(Utils.backendUrl! + '/api/user'),
      body: json.encode({
        "uuid": userId,
        "name": data['name'],
        "preferences": data['preferences'],
        "location": data['location'],
      }),
      headers: {
        ...Utils.headerValue,
        'auth-token': token!,
      },
    );
    print('here');
  }
}
