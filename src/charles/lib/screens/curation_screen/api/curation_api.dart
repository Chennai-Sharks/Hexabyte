import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:hexabyte/utils/utils.dart';

class CurationApi {
  static Future<Map<dynamic, dynamic>> getCurationData({required Map data}) async {
    print(data);
    final serverResponse = await http.post(
      Uri.parse('${Utils.backendUrl!}/combo_buy/'),
      body: json.encode(data),
    );

    final response = json.decode(serverResponse.body);

    if (serverResponse.statusCode == 200) {
      return response['data'];
    } else {
      return {};
    }
  }

  static Future<int> itemPurchase({required Map data}) async {
    print(data);
    final serverResponse = await http.post(
      Uri.parse('${Utils.backendUrl!}/purchase_item/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}'),
      body: json.encode(data),
    );

    final response = json.decode(serverResponse.body);

    if (serverResponse.statusCode == 200) {
      return 1;
    } else {
      return -1;
    }
  }
}
