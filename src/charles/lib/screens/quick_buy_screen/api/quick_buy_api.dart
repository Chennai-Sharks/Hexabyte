import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import 'package:hexabyte/utils/utils.dart';

class QuickBuyApi {
  static Future<List<dynamic>> nearestItems() async {
    final serverResponse = await http.get(
      Uri.parse('${Utils.backendUrl!}/nearest/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}'),
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
