/*
* Created By MiraiDevs
* On 6/12/25.
*/

import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  static final AppColor _instance = AppColor._();

  static AppColor get instance => _instance;

  // ============================================================
  // Brand Colors - Consistent across themes
  // ============================================================
  static const Color kcPrimary = Color(0xFF4720AD);
  static const Color kcPrimaryDark = Color(0xFF321480);
  static const Color kcPrimaryLight = Color(0xFFF2EDFC);
  static const Color kcSecondary = Color(0xFF31C9F4);
  static const Color kcSecondaryDark = Color(0xFF1AA6CE);
  static const Color kcSecondaryLight = Color(0xFFE5F9FE);
  static const Color kcAccent = Color(0xFFEE2FA1);
  static const Color kcFox = Color(0xFFFEB939);

  // ============================================================
  // Semantic Colors - Status & Feedback
  // ============================================================
  static const Color success = Color(0xFF00A261);
  static const Color successDark = Color(0xFF007A4A);
  static const Color successLight = Color(0xFFEAFFF1);

  static const Color error = Color(0xFFF8285A);
  static const Color errorDark = Color(0xFFD91F4A);
  static const Color errorLight = Color(0xFFFEE2E2);

  static const Color warning = Color(0xFFF6B100);
  static const Color warningDark = Color(0xFFDFA000);
  static const Color warningLight = Color(0xFFFFF8DD);

  static const Color info = Color(0xFF007AFF);
  static const Color infoDark = Color(0xFF0056B3);
  static const Color infoLight = Color(0xFFE5F2FF);

  // ============================================================
  // Light Theme Colors
  // ============================================================
  static const Color lightBG = Color(0xFFF8F9FC);
  static const Color lightSurface = Colors.white;
  static const Color textPrimaryLight = Color(0xFF1E1B39);
  static const Color textSecondaryLight = Color(0xFF75748E);
  static const Color borderLight = Color(0xFFE8E9F1);
  static const Color disabledLight = Color(0xFFD2D3E0);

  // ============================================================
  // Dark Theme Colors
  // ============================================================
  static const Color darkBG = Color(0xFF110E24);
  static const Color darkSurface = Color(0xFF1D1938);
  static const Color textPrimaryDark = Color(0xFFF6F6FA);
  static const Color textSecondaryDark = Color(0xFFA5A4BE);
  static const Color borderDark = Color(0xFF2C274E);
  static const Color disabledDark = Color(0xFF453F6B);
}
