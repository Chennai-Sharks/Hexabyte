import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:http/http.dart' as http;

class OrderHistoryApi {
  static Future<List<dynamic>> getMyOrders() async {
    print('${Utils.backendUrl!}/customer_orders/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}');
    final serverResponse = await http.get(
      Uri.parse('${Utils.backendUrl!}/customer_orders/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}'),
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
