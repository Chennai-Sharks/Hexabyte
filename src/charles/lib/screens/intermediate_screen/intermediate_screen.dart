import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexabyte/screens/auth_screen/auth_screen.dart';
import 'package:hexabyte/screens/loading_screen/loading_screen.dart';
import 'package:hexabyte/screens/select_role_screen.dart/select_role_screen.dart';

class IntermediateScreen extends StatelessWidget {
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();

  IntermediateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initFirebaseSdk,
        builder: (_, snapshot) {
          final navContext = Navigator.of(context);
          if (snapshot.hasError) return const Scaffold();

          if (snapshot.connectionState == ConnectionState.done) {
            // Assign listener after the SDK is initialized successfully
            FirebaseAuth.instance.authStateChanges().listen((User? user) {
              if (user == null) {
                navContext.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AuthScreen(),
                  ),
                );
              } else {
                navContext.pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SelectRoleScreen(),
                  ),
                );
              }
            });
          }

          return const LoadingScreen();
        });
  }
}
