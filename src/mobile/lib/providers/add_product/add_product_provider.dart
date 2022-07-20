import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexabyte/utils/utils.dart';

import 'package:http/http.dart' as http;

class AddProductProvider {
  final storage = const FlutterSecureStorage();

  Future<void> addProduct(
    Map<String, dynamic> data,
  ) async {
    final token = await storage.read(key: 'token');
    print(token);

    final response = await http.post(
      Uri.parse(Utils.backendUrl! + '/api/sell'),
      body: json.encode(data),
      headers: {
        ...Utils.headerValue,
        'auth-token': token!,
      },
    );
    print('done add product');
  }
}
