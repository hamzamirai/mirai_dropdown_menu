import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/core/localization/localization_manager.dart';
import 'app/core/localization/state/language_notifier.dart';
import 'app/core/theme/app_theme.dart';
import 'app/core/utils/app_size_config.dart';
import 'app/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LanguageNotifier.instance,
      builder: (BuildContext context, Widget? _) {
        final Locale currentLocale = LanguageNotifier.instance.currentLocale;

        return LayoutBuilder(
          builder: (_, BoxConstraints boxConstraints) {
            return OrientationBuilder(
              builder: (_, Orientation orientation) {
                /// init sizes
                AppSizeConfig.init(
                  orientation: orientation,
                  constraints: boxConstraints,
                );
                return MaterialApp(
                  title: 'Mirai Dropdown Menu Example',
                  debugShowCheckedModeBanner: false,
                  theme: AppTheme.light(),
                  darkTheme: AppTheme.dark(),
                  themeMode: ThemeMode.light,
                  locale: currentLocale,
                  supportedLocales: AppLocalization.supportedLocales,
                  localizationsDelegates: <LocalizationsDelegate<dynamic>>[
                    const AppLocalizationDelegate(),
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  home: const HomeScreen(title: 'Mirai Dropdown Menu\nExample'),
                );
              },
            );
          },
        );
      },
    );
  }
}
