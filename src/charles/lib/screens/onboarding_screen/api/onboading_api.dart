import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:hexabyte/utils/utils.dart';

class OnboardingApi {
  static Future<int> dataCollection({required Map data}) async {
    final serverResponse = await http.post(
      Uri.parse('${Utils.backendUrl!}/data_collection/'),
      body: json.encode(data),
    );

    final response = json.decode(serverResponse.body);
    print(response);

    if (serverResponse.statusCode == 200) {
      return 1;
    } else {
      return -1;
    }
  }
}
