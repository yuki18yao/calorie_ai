import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  primarySwatch: Colors.orange,
  primaryColor: Colors.orange[700],
  scaffoldBackgroundColor: Colors.grey[100],
  visualDensity: VisualDensity.adaptivePlatformDensity,
  appBarTheme: AppBarTheme(
    color: Colors.orange[700],
    elevation: 2,
    titleTextStyle: GoogleFonts.oswald(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.orange[700],
    foregroundColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.orange[700],
    textTheme: ButtonTextTheme.primary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: GoogleFonts.oswald(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: GoogleFonts.oswald(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: Colors.orange[700]!),
      textStyle: GoogleFonts.oswald(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: GoogleFonts.oswaldTextTheme().copyWith(
    displayLarge: GoogleFonts.oswald(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    displayMedium: GoogleFonts.oswald(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    displaySmall: GoogleFonts.oswald(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineMedium: GoogleFonts.oswald(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    headlineSmall: GoogleFonts.oswald(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleLarge: GoogleFonts.oswald(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black87,
    ),
    titleMedium: GoogleFonts.oswald(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    titleSmall: GoogleFonts.oswald(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    ),
    bodyLarge: GoogleFonts.oswald(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodyMedium: GoogleFonts.oswald(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.black87,
    ),
    bodySmall: GoogleFonts.oswald(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.grey[600],
    ),
    labelSmall: GoogleFonts.oswald(
      fontSize: 10,
      fontWeight: FontWeight.normal,
      color: Colors.grey[600],
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.orange[700]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.orange[700]!),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[400]!),
    ),
    labelStyle: GoogleFonts.oswald(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.orange[700],
    ),
    hintStyle: GoogleFonts.oswald(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey[600],
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.orange[700],
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.white,
  ),
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
  ).copyWith(
    secondary: Colors.orangeAccent,
  ),
);
