import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexabyte/utils/utils.dart';

import 'package:http/http.dart' as http;

class HomeProvider {
  final storage = const FlutterSecureStorage();
  Future<List> recommended({String? userId}) async {
    print('homepage func');
    final token = await storage.read(key: 'token');

    print(token);
    print(Utils.backendUrl! + '/api/home');
    final checkResponse = await http.get(
      Uri.parse(Utils.backendUrl! + '/api/home'),
      headers: {
        ...Utils.headerValue,
        'auth-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiRE0xU3E4UkQySVpsOFNuNmttNWViVW1DRkFxMiIsImxvY2F0aW9uIjoiT2Rpc2hhIn0.qHOCoQp8N9YpsEFg_tlZZESO7eT_KA3Ud7w3r1y_ypY',
      },
    );
    log(checkResponse.body);
    final output = json.decode(checkResponse.body);
    print(output);
    print('home');
    return output;
  }
}
