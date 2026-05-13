import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  // colors
  //static Color primaryColor = Colors.Black.wit0pacity(0.8)
  static Color primaryColor = Color(0xFF085B63);
  static Color secondaryColor = primaryColor.withValues(alpha: 0.7);
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF1A1A1A);
  static const Color greyColor = Color(0xFFF5F5F5);

  //Text Styles
  static TextStyle get headingStyle => GoogleFonts.outfit(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor
      );

  static TextStyle get titleStyle => GoogleFonts.outfit(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor
      );

  static TextStyle get bodyStyle => GoogleFonts.outfit(
        fontSize: 16,
        color: textColor
      );

  //Padding
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;

  // Border Radius
  static const double defaultBorderRadius = 26.0;
  static const double smallBorderRadius = 8.0;
  static const double largeBorderRadius = 16.0;

  // Animation Duration
  static const Duration defaultDuration = Duration(milliseconds: 300);
}