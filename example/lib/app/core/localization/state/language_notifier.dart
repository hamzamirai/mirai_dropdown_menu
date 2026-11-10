/*
* Created By MiraiDevs
* On 6/12/25.
*/

import 'package:flutter/widgets.dart';

import '../localization_manager.dart';

class LanguageNotifier extends ChangeNotifier {
  LanguageNotifier._();

  static final LanguageNotifier instance = LanguageNotifier._();

  Locale _locale = const Locale('en', 'US');

  Locale get currentLocale => _locale;

  void changeLanguage(Locale newLocale) {
    if (_locale.languageCode == newLocale.languageCode) return;
    _locale = newLocale;
    notifyListeners();
  }

  void changeLanguageByCode(String languageCode) {
    final Locale targetLocale = AppLocalization.supportedLocales.firstWhere(
      (Locale locale) => locale.languageCode == languageCode,
      orElse: () => const Locale('en', 'US'),
    );
    changeLanguage(targetLocale);
  }
}
