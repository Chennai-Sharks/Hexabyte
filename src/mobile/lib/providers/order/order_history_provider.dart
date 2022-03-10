import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexabyte/utils/utils.dart';

import 'package:http/http.dart' as http;

class OrderHistoryProvider {
  final storage = const FlutterSecureStorage();

  Future<List> orderHistory() async {
    print('doing');
    final token = await storage.read(key: 'token');
    print(token);

    final response = await http.get(
      Uri.parse(Utils.backendUrl! + '/api/orderHistory'),
      headers: {
        ...Utils.headerValue,
        'auth-token': token!,
      },
    );
    print('here order history');
    print(json.decode(response.body));

    return json.decode(response.body);
  }
}
