import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';
import 'package:hexabyte/providers/auth/auth_provider.dart';
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

  Future<void> verifyPhoneSendOtp({
    required String phone,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credentials) async {
          Fluttertoast.showToast(msg: 'OTP sent to your phone number', toastLength: Toast.LENGTH_LONG);
        },
        verificationFailed: (e) {
          Fluttertoast.showToast(
              msg: 'App verification failed. Maybe due to internet issues.', toastLength: Toast.LENGTH_LONG);
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
      verifyPhoneSendOtp(
        phone: widget.phone,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.primaryBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Verification',
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              'Enter the code sent to the number',
              style: GoogleFonts.rubik(
                fontSize: 22,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '+91 ${widget.phone}',
              style: GoogleFonts.rubik(
                // fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              hapticFeedbackType: HapticFeedbackType.heavyImpact,
              onCompleted: ((value) async {
                try {
                  final userData = await FirebaseAuth.instance.signInWithCredential(
                    PhoneAuthProvider.credential(
                      verificationId: verificationCode!,
                      smsCode: value,
                    ),
                  );
                  if (!mounted) return;
                  final bool isNewUser = userData.additionalUserInfo?.isNewUser as bool;
                  // add the login route code (connection with backend)
                  if (isNewUser) {
                    // await authProvider.register(userId: FirebaseAuth.instance.currentUser!.uid);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                        (route) => false);
                  } else {
                    //uncomment this afterwards.
                    // await authProvider.login(userId: FirebaseAuth.instance.currentUser!.uid);
                    if (!mounted) return;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const NavigationLayout(),
                        ),
                        (route) => false);
                  }
                } catch (error) {
                  Fluttertoast.showToast(
                    msg: 'Problem: ${error.toString()}',
                    toastLength: Toast.LENGTH_LONG,
                  );
                }
              }),
              defaultPinTheme: PinTheme(
                width: 76,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  border: Border.all(color: Colors.black26),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
