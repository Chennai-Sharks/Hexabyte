import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SloganTextWidget extends StatefulWidget {
  final String? sloganText;

  const SloganTextWidget({Key? key, this.sloganText}) : super(key: key);

  @override
  State<SloganTextWidget> createState() => _SloganTextWidgetState();
}

class _SloganTextWidgetState extends State<SloganTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        widget.sloganText!,
        style: GoogleFonts.almarai(
          fontSize: 35,
          color: Colors.yellow,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
