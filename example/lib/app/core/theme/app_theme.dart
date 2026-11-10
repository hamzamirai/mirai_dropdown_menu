/*
* Created By MiraiDevs
* On 6/12/25.
*/

import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_text_theme.dart';

class AppTheme {
  AppTheme._();

  static final AppTheme _instance = AppTheme._();

  static AppTheme get instance => _instance;

  // Border Radius Constants
  static const double borderRadiusS = 6;
  static const double borderRadiusM = 12;
  static const double borderRadiusL = 18;
  static const double borderRadius = borderRadiusM;

  // Gradients
  static const LinearGradient gradientPrimary = LinearGradient(
    colors: <Color>[AppColor.kcPrimary, AppColor.kcSecondary],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient gradientPrimaryI = LinearGradient(
    colors: <Color>[AppColor.kcPrimary, AppColor.kcSecondary],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
  );

  static const LinearGradient gradientSecondary = LinearGradient(
    colors: <Color>[AppColor.kcPrimary, AppColor.kcAccent],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Backward compatibility alias colors
  static const Color appColor = AppColor.kcPrimary;
  static const Color blue = AppColor.kcSecondary;
  static const Color backgroundColor = AppColor.lightBG;
  static const Color borderColor = AppColor.borderLight;
  static const Color unselectedNavItemColor = AppColor.textSecondaryLight;
  static const Color keyAppColor = AppColor.kcPrimary;
  static const Color keyTextBlackColor = AppColor.textPrimaryLight;
  static const Color darkBlueColor = AppColor.textPrimaryLight;

  // Input Borders
  static OutlineInputBorder miraiOutlineInputBorderForTextField({
    Color? color,
    double? borderRadius,
    double? borderWidth,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 10),
      borderSide: BorderSide(
        width: borderWidth ?? 1.5,
        color: color ?? AppColor.kcPrimary,
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
        width: borderWidth ?? 1.5,
        color: color ?? AppColor.kcPrimary,
      ),
    );
  }

  // Light Theme
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColor.kcPrimary,
        onPrimary: Colors.white,
        primaryContainer: AppColor.kcPrimaryLight,
        onPrimaryContainer: AppColor.kcPrimaryDark,
        secondary: AppColor.kcSecondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColor.kcSecondaryLight,
        onSecondaryContainer: AppColor.kcSecondaryDark,
        tertiary: AppColor.info,
        onTertiary: Colors.white,
        tertiaryContainer: AppColor.infoLight,
        onTertiaryContainer: AppColor.infoDark,
        error: AppColor.error,
        onError: Colors.white,
        errorContainer: AppColor.errorLight,
        onErrorContainer: AppColor.errorDark,
        surface: AppColor.lightSurface,
        onSurface: AppColor.textPrimaryLight,
        onSurfaceVariant: AppColor.textSecondaryLight,
        outline: AppColor.borderLight,
        outlineVariant: AppColor.disabledLight,
      ),
      scaffoldBackgroundColor: AppColor.lightBG,
      canvasColor: AppColor.lightSurface,
      cardColor: AppColor.lightSurface,
      dividerColor: AppColor.borderLight,
      primaryColor: AppColor.kcPrimary,
      hintColor: AppColor.textSecondaryLight,
      disabledColor: AppColor.disabledLight,
      textTheme: AppTextTheme.textTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.kcPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  // Dark Theme
  static ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColor.kcPrimary,
        onPrimary: Colors.white,
        primaryContainer: AppColor.kcPrimaryDark,
        onPrimaryContainer: AppColor.kcPrimaryLight,
        secondary: AppColor.kcSecondary,
        onSecondary: Colors.white,
        secondaryContainer: AppColor.kcSecondaryDark,
        onSecondaryContainer: AppColor.kcSecondaryLight,
        tertiary: AppColor.info,
        onTertiary: Colors.white,
        tertiaryContainer: AppColor.infoDark,
        onTertiaryContainer: AppColor.infoLight,
        error: AppColor.error,
        onError: Colors.white,
        errorContainer: AppColor.errorDark,
        onErrorContainer: AppColor.errorLight,
        surface: AppColor.darkSurface,
        onSurface: AppColor.textPrimaryDark,
        onSurfaceVariant: AppColor.textSecondaryDark,
        outline: AppColor.borderDark,
        outlineVariant: AppColor.disabledDark,
      ),
      scaffoldBackgroundColor: AppColor.darkBG,
      canvasColor: AppColor.darkSurface,
      cardColor: AppColor.darkSurface,
      dividerColor: AppColor.borderDark,
      primaryColor: AppColor.kcPrimary,
      hintColor: AppColor.textSecondaryDark,
      disabledColor: AppColor.disabledDark,
      textTheme: AppTextTheme.textTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColor.darkSurface,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  static ThemeData get themeData => light();
}
