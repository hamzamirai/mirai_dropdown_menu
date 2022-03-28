/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_size_config.dart';

abstract class AppTextTheme {
  AppTextTheme._();

  static TextTheme textTheme() {
    return TextTheme(
      button: GoogleFonts.nunito().copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 30,
      ),
      headline1: GoogleFonts.nunito().copyWith(
        fontWeight: FontWeight.bold,
        fontSize: AppSizeConfig.textSize,
      ),
      headline2: GoogleFonts.nunito().copyWith(
        fontWeight: FontWeight.bold,
        fontSize: AppSizeConfig.textSize - 2,
      ),
      bodyText1: GoogleFonts.nunito().copyWith(
        fontSize: AppSizeConfig.textSize - 4,
      ),
      bodyText2: GoogleFonts.nunito().copyWith(
        fontSize: AppSizeConfig.textSize - 6,
      ),
      subtitle1: GoogleFonts.nunito().copyWith(
        fontWeight: FontWeight.w100,
        fontSize: AppSizeConfig.textSize - 8,
      ),
      subtitle2: GoogleFonts.nunito().copyWith(
        fontWeight: FontWeight.w100,
        fontSize: AppSizeConfig.textSize - 10,
      ),
    );
  }
}
