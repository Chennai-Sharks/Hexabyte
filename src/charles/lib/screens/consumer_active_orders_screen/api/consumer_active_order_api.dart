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
}
