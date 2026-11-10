/*
* Created By MiraiDevs
* On 6/12/25.
*/

import 'package:flutter/material.dart';

import '../localization/localization_manager.dart';

extension LocalizationStringExtension on String {
  String tr(BuildContext context) {
    return AppLocalization.of(context)?.translate(this) ?? this;
  }
}

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isRtl => Directionality.of(this) == TextDirection.rtl;

  String tr(String key) => AppLocalization.of(this)?.translate(key) ?? key;
}
