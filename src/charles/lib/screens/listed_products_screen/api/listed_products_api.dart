import 'dart:convert';

import 'package:hexabyte/utils/utils.dart';
import 'package:http/http.dart' as http;

class ListedProductApi {
  static Future<void> getMyProducts({required List data}) async {
    final serverResponse = await http.get(
      Uri.parse('${Utils.backendUrl!}/some_route/'),
    );
    final response = json.decode(serverResponse.body);

    print(response);

    if (serverResponse.statusCode == 200) {
      final response = json.decode(serverResponse.body);

      data = response['data'];
    }
  }
}
