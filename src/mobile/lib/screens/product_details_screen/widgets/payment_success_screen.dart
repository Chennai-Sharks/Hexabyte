import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexabyte/layout/nav_layout.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Your Payment is Successful !!!',
            style: GoogleFonts.exo(fontSize: 25, color: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.6),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NavigationLayout()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                decoration: BoxDecoration(color: Colors.redAccent.shade700, borderRadius: BorderRadius.circular(15)),
                child: Center(
                  child: Text(
                    'Go To Home Page',
                    style: GoogleFonts.exo(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
