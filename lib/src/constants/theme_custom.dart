import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeCustom {
  static const Color primaryColor = Color(0xFFFE8B00);
  static const Color secondaryColor = Color(0xFF343434);
  static const Color thirdColor = Color(0xFFD8D8D8);
  static const Color blueColor = Color(0xFF4FB6FF);
  static const Color yellowColor = Color(0xFFFAB700);

  static ThemeData themeSetting() {
    return ThemeData(
      primarySwatch: Colors.orange,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      backgroundColor: Colors.white,
      fontFamily: GoogleFonts.rubik().fontFamily,
    );
  }
}
