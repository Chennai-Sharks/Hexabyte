import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hexabyte/screens/home_screen/home_screen.dart';
import 'package:hexabyte/screens/onboarding_screen/onboarding_screen.dart';
import 'package:hexabyte/utils/utils.dart';

import 'package:http/http.dart' as http;

class AuthProvider {
  final storage = const FlutterSecureStorage();

  Future<void> login({String? userId}) async {
    final checkResponse = await http.get(
      Uri.parse(Utils.backendUrl! + '/api/login/$userId'),
    );
    print(checkResponse);
    print(checkResponse.headers['auth-token']);
    await storage.write(key: 'token', value: checkResponse.headers['auth-token']);
  }

  Future<void> register({required String userId, required dynamic data}) async {
    //  final token = await storage.read(key: 'token');
    final checkResponse = await http.post(
      Uri.parse(Utils.backendUrl! + '/api/register'),
      body: json.encode({
        'uuid': userId,
        'name': data['name'],
        'location': data['state'],
        'preferences': data['preferences'],
      }),
      headers: {
        ...Utils.headerValue,
        // 'auth-token': token!
      },
    );
    print(checkResponse);
    await storage.write(key: 'token', value: checkResponse.headers['auth-token']);

    print(checkResponse.headers['auth-token']);
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await FirebaseAuth.instance.signOut();
  }
}
