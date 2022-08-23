import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SloganTextWidget extends StatefulWidget {
  late final String? sloganText;

  @override
  State<SloganTextWidget> createState() => _SloganTextWidgetState();
}

class _SloganTextWidgetState extends State<SloganTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          widget.sloganText!,
          style: GoogleFonts.almarai(
            fontSize: 35,
            color: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
