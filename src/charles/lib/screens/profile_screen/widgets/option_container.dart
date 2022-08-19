import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget optionContainer(Color? color, Icon? icon, String? text, BuildContext context, dynamic onTap) {
  Size? size = MediaQuery.of(context).size;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: size.width * 0.16,
          height: size.width * 0.16,
          child: Center(
            child: icon!,
          ),
          decoration: BoxDecoration(
            color: color!,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(spreadRadius: 1, blurRadius: 5, color: Colors.black.withAlpha(100)),
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text!,
          style: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
