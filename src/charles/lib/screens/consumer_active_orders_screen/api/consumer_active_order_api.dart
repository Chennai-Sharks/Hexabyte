import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:http/http.dart' as http;

class ConsumerActiveOrdersApi {
  static Future<List> getOrders() async {
    final serverResponse = await http.get(
      Uri.parse('${Utils.backendUrl!}/customer_live/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}'),
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

  static Future<int> setProductReceived(String id) async {
    print('${Utils.backendUrl!}/order_complete/$id/');
    final serverResponse = await http.put(
      Uri.parse('${Utils.backendUrl!}/order_complete/$id/'),
    );
    final response = json.decode(serverResponse.body);

    print(response);

    if (serverResponse.statusCode == 200) {
      return 1;
    } else {
      return 0;
    }
  }
}
