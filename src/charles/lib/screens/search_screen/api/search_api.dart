import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:hexabyte/utils/utils.dart';

class SearchApi {
  static Future<List<dynamic>> productSearch({required String searchText}) async {
    final serverResponse = await http.post(
      Uri.parse('${Utils.backendUrl!}/product_search/'),
      body: json.encode({
        "phone": FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3),
        "tags": [],
        "query": searchText,
      }),
    );
    final response = json.decode(serverResponse.body);

    print(response);

    if (serverResponse.statusCode == 200) {
      final response = json.decode(serverResponse.body);
      print(response);
      return response['data'];
    } else {
      return [];
    }
  }
}
