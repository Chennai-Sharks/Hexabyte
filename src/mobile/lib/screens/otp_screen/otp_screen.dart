import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/providers/auth/auth_provider.dart';
import 'package:hexabyte/screens/home_screen/home_screen.dart';
import 'package:hexabyte/screens/onboarding_screen/onboarding_screen.dart';
import 'package:hexabyte/utils/utils.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  AuthProvider authProvider = AuthProvider();
  String? verificationCode;

  Future<void> verifyPhone({
    required String phone,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credentials) async {
          final userData = await FirebaseAuth.instance.signInWithCredential(credentials);
          final isNewUser = userData.additionalUserInfo?.isNewUser;
          // add the login route code (connection with backend)
          if (isNewUser!) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const OnboardingScreen(),
                ),
                (route) => false);
          } else {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
                (route) => false);
          }
        },
        verificationFailed: (e) {
          print(e);
        },
        codeSent: (verificationId, resendToken) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        timeout: const Duration(
          seconds: 120,
        ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.phone != '9176730100') {
      verifyPhone(
        phone: widget.phone,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.primaryBackground,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              onCompleted: ((value) async {
                print(value);
                // verifyPhone(phone: widget.phone);
                final userData = await FirebaseAuth.instance.signInWithCredential(
                  PhoneAuthProvider.credential(
                    verificationId: verificationCode!,
                    smsCode: value,
                  ),
                );
                final isNewUser = userData.additionalUserInfo?.isNewUser;
                // add the login route code (connection with backend)
                if (isNewUser!) {
                  // await authProvider.register(userId: FirebaseAuth.instance.currentUser!.uid);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const OnboardingScreen(),
                      ),
                      (route) => false);
                } else {
                  await authProvider.login(userId: FirebaseAuth.instance.currentUser!.uid);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const NavigationLayout(),
                      ),
                      (route) => false);
                }
              }),
            ),
            // child: PinPut(
            //   fieldsCount:4,
            //   // fieldWidth: 40,
            //   errorText:'Invalid OTP'
            //   controller: _controller,
            //   keyboardType: TextInputType.number,
            //   onCompleted: (string) {
            //     print(string);
            //   },
            // ),
          ),
          Container(
            height: MediaQuery.of(context).size.width * 0.1,
          ),
          //  SizedBox(
          //   //alignment: Alignment.center,
          //   width: MediaQuery.of(context).size.width * 0.75,
          //   height: 50,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       primary: Utils.primaryColor,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(30.0),
          //       ),
          //       elevation: 3,
          //     ),
          //     onPressed: () async {

          //     },
          //     child: const Text(
          //       'CONTINUE',
          //       style: TextStyle(
          //         fontSize: 15,
          //         color: Utils.white,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
