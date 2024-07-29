/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:flutter/material.dart';

abstract class AppSizeConfig {
  AppSizeConfig._();

  static double screenWidth = 600.0;
  static late double textSize;

  static void init({BoxConstraints? constraints, Orientation? orientation}) {
    if (constraints != null) screenWidth = constraints.maxWidth;

    if (screenWidth <= 500) {
      textSize = 18;
    }
    //
    else if (screenWidth <= 700) {
      textSize = 22;
    }
    //
    else if (screenWidth < 1000) {
      textSize = 26;
    }
    //
    else {
      textSize = 28;
    }
  }
}
