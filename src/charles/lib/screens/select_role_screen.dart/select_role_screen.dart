import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hexabyte/layout/nav_layout.dart';

class SelectRoleScreen extends StatelessWidget {
  const SelectRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Select role',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFB4E197), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) => NavigationLayout(isConsumer: true))))
                },
                child: const Text('Consumer'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFB4E197), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () => {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) => NavigationLayout(isConsumer: false))))
                },
                child: const Text('Producer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
