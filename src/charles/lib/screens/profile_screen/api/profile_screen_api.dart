import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:http/http.dart' as http;

class ProfileScreenApi {
  static Future<Map> getUserProfile() async {
    final serverResponse = await http.get(
      Uri.parse('${Utils.backendUrl!}/profile_page/${FirebaseAuth.instance.currentUser!.phoneNumber!.substring(3)}'),
    );
    if (serverResponse.statusCode == 200) {
      final response = json.decode(serverResponse.body);

      return response['data'];
    } else {
      return {};
    }
  }
}
