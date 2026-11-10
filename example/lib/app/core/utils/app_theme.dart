/*
* Created By Mirai Devs.
* On 3/28/2022.
* Updated to match MiraiDevs Portfolio Design System
*/
import 'package:flutter/material.dart';

import 'app_theme_text.dart';

class AppTheme {
  static final AppTheme _singleton = AppTheme._internal();

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();

  // Modern Purple & Blue Gradient Theme (Portfolio Design)
  static const Color appColor = Color(0xFF4720ad);
  static const Color blue = Color(0xFF31C9F4);
  static const Color blueLogo = Color(0xFF2DD1F6);
  static const Color mColor = Color(0xFF617EDB);
  static const Color dColor = Color(0xFF2FCCF4);
  static const Color selectedNavItemColor = Color(0xFF4444de);
  static const Color unselectedNavItemColor = Color(0xFF8a89a1);
  static const Color pinkColor = Color(0xFFee2fa1);
  static const Color lightDatePickerPinkColor = Color(0xFFFDE6F6);
  static const Color blueColor = Color(0xFF151443);
  static const Color darkBlueColor = Color(0xFF111127);
  static const Color overlayBlueColor = Color(0xFF21204c);
  static const Color blackColor = Color(0xFF000000);
  static const Color lightBlueColor = Color(0xFF292985);
  static const Color lightPurpleColor = Color(0xFFc7c7f5);
  static const Color purpleColor = Color(0xFF8F8FEB);
  static const Color textGradientFirstColor = Color(0xFF6A69E5);
  static const Color textGradientSecondColor = Color(0xFFEF0AA1);
  static const Color backgroundColor = Color(0xFFF0F2F5);
  static const Color borderColor = Color(0xFFECECFC);
  static const Color lightPinkColor = Color(0xFFFDE7F6);
  static const Color greenLightColor = Color(0xFFD9F2E5);
  static const Color greenDarkColor = Color(0xFF26734D);
  static const Color greenColor = Color(0xFF40BF80);
  static const Color greyColor = Color(0xFFE4E7EC);
  static const Color greyPurpleColor = Color(0xFFB5B4F2);
  static const Color greyOrangeColor = Color(0xFFF5A300);

  // Legacy color names for backward compatibility
  static const Color keyAppColor = appColor;
  static const Color keyTextBlackColor = Color(0xFF313131);
  static const Color backgroundGrayColor = backgroundColor;
  static const Color keyDarkBlueColor = darkBlueColor;

  static Duration shimmerDuration = const Duration(milliseconds: 1200);
  static Color highlightColorShimmer = purpleColor.withValues(alpha: 0.4);
  static Color baseColorShimmer = lightPurpleColor.withValues(alpha: 0.5);

  // Input Border Styles
  static OutlineInputBorder miraiOutlineInputBorderForTextField({
    Color? color,
    double? borderRadius,
    double? borderWidth,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        width: borderWidth ?? 2,
        color: color ?? appColor,
      ),
    );
  }

  static UnderlineInputBorder miraiUnderlineInputBorder({
    Color? color,
    double? borderRadius,
    double? borderWidth,
  }) {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        width: borderWidth ?? 2,
        color: color ?? appColor,
      ),
    );
  }

  // ThemeData
  static ThemeData get themeData => ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: appColor),
        scaffoldBackgroundColor: backgroundColor,
        primaryColor: appColor,
        textTheme: AppTextTheme.textTheme(),
        brightness: Brightness.light,
        useMaterial3: true,
      );
}
