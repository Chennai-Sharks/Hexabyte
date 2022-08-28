import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/screens/onboarding_screen/onboarding_screen.dart';
import 'package:hexabyte/screens/select_role_screen.dart/select_role_screen.dart';
import 'package:pinput/pinput.dart';

import '../../utils/utils.dart';

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
  String? verificationCode;

  Future<void> verifyPhoneSendOtp({
    required String phone,
  }) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credentials) async {
          Fluttertoast.showToast(msg: 'Verification done!', toastLength: Toast.LENGTH_LONG);
        },
        verificationFailed: (e) {
          Fluttertoast.showToast(
              msg: 'App verification failed. Maybe due to internet issues.', toastLength: Toast.LENGTH_LONG);
        },
        codeSent: (verificationId, resendToken) {
          Fluttertoast.showToast(msg: 'OTP sent to your phone number', toastLength: Toast.LENGTH_LONG);

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
    final defaultPinTheme = PinTheme(
      width: 76,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Theme.of(context).secondaryHeaderColor),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Utils.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Verification',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).secondaryHeaderColor,
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
              style: GoogleFonts.montserrat(
                fontSize: 22,
                color: Theme.of(context).secondaryHeaderColor.withAlpha(700),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              '+91 ${widget.phone}',
              style: GoogleFonts.montserrat(
                // fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: defaultPinTheme,
              hapticFeedbackType: HapticFeedbackType.heavyImpact,
              onCompleted: ((value) async {
                final navContext = Navigator.of(context);
                EasyLoading.show(status: 'Loading...');
                try {
                  final userData = await FirebaseAuth.instance.signInWithCredential(
                    PhoneAuthProvider.credential(
                      verificationId: verificationCode!,
                      smsCode: value,
                    ),
                  );
                  final bool isNewUser = userData.additionalUserInfo?.isNewUser as bool;
                  if (isNewUser) {
                    await EasyLoading.dismiss();
                    navContext.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                        (route) => false);
                  } else {
                    await EasyLoading.dismiss();
                    navContext.pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const SelectRoleScreen(),
                        ),
                        (route) => false);
                  }
                } catch (error) {
                  await EasyLoading.dismiss();
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
                  border: Border.all(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () async {
              await verifyPhoneSendOtp(phone: widget.phone);
            },
            child: Text('Resend'),
          ),
        ],
      ),
    );
  }
}
