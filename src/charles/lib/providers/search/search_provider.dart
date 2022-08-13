import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexabyte/utils/utils.dart';

import 'package:http/http.dart' as http;

class SearchProvider {
  final storage = const FlutterSecureStorage();

  Future<List> searchResults({required String query, String category = ''}) async {
    print(query);
    print('doing');
    final token = await storage.read(key: 'token');
    print(token);

    final response = await http.post(
      Uri.parse(Utils.backendUrl! + '/api/search'),
      body: json.encode({
        "query": query,
        "category": category,
      }),
      headers: {
        ...Utils.headerValue,
        'auth-token': token!,
      },
    );
    final responseData = json.decode(response.body);
    print(responseData);
    print('here');

    return responseData;
  }
}
