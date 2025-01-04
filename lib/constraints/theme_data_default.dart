import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData ezycourseTheme = ThemeData(
  // brightness: Brightness.dark,
  primaryColor: const Color(0xFF00C853),
  // scaffoldBackgroundColor: const Color(0xFF00263F),
  textTheme: TextTheme(
    headlineMedium: GoogleFonts.figtree(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    bodyLarge: GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
    titleMedium: GoogleFonts.figtree(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.white70,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF004866),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide.none,
    ),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    labelStyle: GoogleFonts.figtree(
      fontSize: 16,
      color: Colors.white70,
    ),
    hintStyle: GoogleFonts.figtree(
      fontSize: 16,
      color: Colors.white54,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(const Color(0xFF00C853)),
    checkColor: WidgetStateProperty.all(Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFE9FF46),
      foregroundColor: Colors.black,
      textStyle: GoogleFonts.figtree(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15.0),
    ),
  ),
);
