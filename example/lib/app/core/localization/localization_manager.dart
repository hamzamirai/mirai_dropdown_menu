/*
* Created By MiraiDevs
* On 6/12/25.
*/

import 'package:flutter/widgets.dart';

import 'supported_locales/ar.dart';
import 'supported_locales/de.dart';
import 'supported_locales/en.dart';
import 'supported_locales/es.dart';
import 'supported_locales/fr.dart';
import 'supported_locales/pt.dart';
import 'supported_locales/ru.dart';
import 'supported_locales/zh.dart';

class AppLocalization {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) =>
      Localizations.of<AppLocalization>(context, AppLocalization);

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en', 'US'),
    Locale('ar', 'SA'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('es', 'ES'),
    Locale('pt', 'PT'),
    Locale('ru', 'RU'),
    Locale('zh', 'CN'),
  ];

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
        'ar': ar,
        'de': de,
        'en': en,
        'es': es,
        'fr': fr,
        'pt': pt,
        'ru': ru,
        'zh': zh,
      };

  String translate(String key) =>
      _localizedValues[locale.languageCode]?[key] ?? key;
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization> {
  const AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalization.supportedLocales.any(
        (Locale supportedLocale) =>
            supportedLocale.languageCode == locale.languageCode,
      );

  @override
  Future<AppLocalization> load(Locale locale) async => AppLocalization(locale);

  @override
  bool shouldReload(LocalizationsDelegate<dynamic> old) => false;
}
