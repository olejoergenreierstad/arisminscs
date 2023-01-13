import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget contentViHjelperDeg(double screenWidth) {
  return Text(
    'Vi hjelper deg som er plaget av pollen',
    style: GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize:
                3 * (screenWidth / 100) > 14 ? 3 * (screenWidth / 100) : 14,
            fontWeight: FontWeight.w300,
            color: Colors.white)),
  );
}
