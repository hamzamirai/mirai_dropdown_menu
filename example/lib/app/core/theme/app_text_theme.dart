/*
* Created By MiraiDevs
* On 6/12/25.
*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme([BuildContext? context]) {
    final double scale = context != null ? MediaQuery.sizeOf(context).width / 430 : 1.0;
    final double factor = scale.clamp(0.85, 1.2);
    final TextStyle textStyle = GoogleFonts.plusJakartaSans();

    return TextTheme(
      displayLarge: textStyle.copyWith(
        fontSize: 56 * factor,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
      ),
      displayMedium: textStyle.copyWith(
        fontSize: 44 * factor,
        fontWeight: FontWeight.w400,
      ),
      displaySmall: textStyle.copyWith(
        fontSize: 34 * factor,
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: textStyle.copyWith(
        fontSize: 30 * factor,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      headlineMedium: textStyle.copyWith(
        fontSize: 26 * factor,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: textStyle.copyWith(
        fontSize: 22 * factor,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: textStyle.copyWith(
        fontSize: 20 * factor,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: textStyle.copyWith(
        fontSize: 16 * factor,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: textStyle.copyWith(
        fontSize: 14 * factor,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: textStyle.copyWith(
        fontSize: 16 * factor,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: textStyle.copyWith(
        fontSize: 14 * factor,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: textStyle.copyWith(
        fontSize: 12 * factor,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: textStyle.copyWith(
        fontSize: 14 * factor,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: textStyle.copyWith(
        fontSize: 12 * factor,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: textStyle.copyWith(
        fontSize: 11 * factor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
