/*
* Created By Mirai Devs.
* On 3/28/2022.
* Updated to match MiraiDevs Portfolio Typography
*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

abstract class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme() {
    return TextTheme(
      // Label styles (typically for buttons and interactive elements)
      labelLarge: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
      labelMedium: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      labelSmall: GoogleFonts.nunito(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      
      // Display styles (headings and large text)
      displayLarge: GoogleFonts.nunito(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        color: AppTheme.darkBlueColor,
      ),
      displayMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.bold,
        fontSize: 24,
        color: AppTheme.darkBlueColor,
      ),
      displaySmall: GoogleFonts.nunito(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: AppTheme.darkBlueColor,
      ),
      
      // Headline styles
      headlineLarge: GoogleFonts.nunito(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: AppTheme.blueColor,
      ),
      headlineMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: AppTheme.blueColor,
      ),
      headlineSmall: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        color: AppTheme.blueColor,
      ),
      
      // Body styles (regular text)
      bodyLarge: GoogleFonts.nunito(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        color: AppTheme.blueColor,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppTheme.blueColor,
      ),
      bodySmall: GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: AppTheme.lightPurpleColor,
      ),
      
      // Title styles
      titleLarge: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppTheme.appColor,
      ),
      titleMedium: GoogleFonts.nunito(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        color: AppTheme.appColor,
      ),
      titleSmall: GoogleFonts.nunito(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        color: AppTheme.appColor,
      ),
    );
  }
}
