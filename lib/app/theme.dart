import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ToDoListTheme {
  static const Color purple = Color(0xff6D28D9);
  static const Color black = Color(0xff1F2937);
  static const Color white = Color(0xffffffff);
  static const Color gray = Color(0xffE5E7EB);

  static ThemeData theme = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.light().textTheme,
    ),
    scaffoldBackgroundColor: gray,
    primaryColor: white,
  );
}
