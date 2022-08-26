import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:http/http.dart' as http;

class PurchaseProductApi {
  static Future<int> purchaseApi({required Map data}) async {
    print(data);
    print('${Utils.backendUrl!}/customer_orders/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}');
    final serverResponse = await http.post(
      Uri.parse('${Utils.backendUrl!}/purchase_item/'),
      body: json.encode(data),
    );
    final response = json.decode(serverResponse.body);

    print(response);

    if (serverResponse.statusCode == 200) {
      final response = json.decode(serverResponse.body);
      print(response);
      return 1;
    } else {
      return 0;
    }
  }
}
