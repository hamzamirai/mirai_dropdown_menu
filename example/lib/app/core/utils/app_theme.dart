/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:flutter/material.dart';

import 'app_theme_text.dart';

abstract class AppTheme {
  AppTheme._();

  static const Color keyAppColor = Color(0xFF1488CC);
  static const Color keyTextBlackColor = Color(0xFF313131);
  static const Color backgroundGrayColor = Color(0xFFF2F2F4);
  static const Color keyDarkBlueColor = Color(0xFF2F3241);

  // ThemeData
  static ThemeData get themeData => ThemeData(
        appBarTheme: const AppBarTheme(color: keyAppColor),
        primaryColor: keyAppColor,
        textTheme: AppTextTheme.textTheme(),
      );
}
