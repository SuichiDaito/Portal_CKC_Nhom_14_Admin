import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleOfWidget {
  static TextStyle textStyle1({
    double fs = 10,
    Color clr = Colors.black,
    FontWeight fw = FontWeight.normal,
  }) => GoogleFonts.roboto(
    textStyle: TextStyle(
      decoration: TextDecoration.none, //Remove underline
      fontSize: fs,
      fontWeight: fw,
      color: clr,
    ),
  );
}
