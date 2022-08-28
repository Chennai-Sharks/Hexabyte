import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:http/http.dart' as http;

class ListedProductApi {
  static Future<List> getMyProducts() async {
    final serverResponse = await http.get(
      Uri.parse('${Utils.backendUrl!}/producer_items/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}'),
    );
    final response = json.decode(serverResponse.body);

    print(response);

    if (serverResponse.statusCode == 200) {
      final response = json.decode(serverResponse.body);

      return response['data'];
    } else {
      return [];
    }
  }
}
