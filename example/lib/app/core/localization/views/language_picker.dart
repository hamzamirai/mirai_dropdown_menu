/*
* Created By MiraiDevs
* On 7/30/26.
*/

import 'package:flutter/material.dart';

import '../../theme/app_color.dart';
import '../../theme/app_theme.dart';
import '../../utils/app_extension.dart';
import '../app_language_keys.dart';
import '../localization_manager.dart';
import '../state/language_notifier.dart';

final Map<String, Map<String, String>> languageData =
    <String, Map<String, String>>{
      'en': <String, String>{'name': 'English', 'flag': '🇬🇧'},
      'ar': <String, String>{'name': 'العربية', 'flag': '🇸🇦'},
      'fr': <String, String>{'name': 'Français', 'flag': '🇫🇷'},
      'de': <String, String>{'name': 'Deutsch', 'flag': '🇩🇪'},
      'es': <String, String>{'name': 'Español', 'flag': '🇪🇸'},
      'pt': <String, String>{'name': 'Português', 'flag': '🇵🇹'},
      'ru': <String, String>{'name': 'Русский', 'flag': '🇷🇺'},
      'zh': <String, String>{'name': '中文', 'flag': '🇨🇳'},
    };

class ChangeLanguage {
  static void showSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const LanguagePickerWidget(),
    );
  }
}

class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageNotifier notifier = LanguageNotifier.instance;
    const List<Locale> languages = AppLocalization.supportedLocales;

    return ListenableBuilder(
      listenable: notifier,
      builder: (BuildContext context, Widget? _) {
        final Locale currentLocale = notifier.currentLocale;

        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.75,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(top: 12, bottom: 16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      context.tr(AppLanguagesKeys.selectLanguageKey),
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  itemCount: languages.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (BuildContext context, int index) {
                    final Locale lang = languages[index];
                    final String languageCode = lang.languageCode;
                    final bool isSelected =
                        currentLocale.languageCode == languageCode;
                    final String languageName =
                        languageData[languageCode]?['name'] ?? languageCode;
                    final String flagEmoji =
                        languageData[languageCode]?['flag'] ?? '🌐';

                    return Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          notifier.changeLanguage(lang);
                          Navigator.of(context).pop();
                        },
                        borderRadius:
                            BorderRadius.circular(AppTheme.borderRadiusM),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            gradient:
                                isSelected ? AppTheme.gradientPrimary : null,
                            color: isSelected
                                ? null
                                : context.colorScheme.surface,
                            borderRadius:
                                BorderRadius.circular(AppTheme.borderRadiusM),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : context.colorScheme.outline,
                              width: 1.5,
                            ),
                            boxShadow: isSelected
                                ? <BoxShadow>[
                                    BoxShadow(
                                      color: AppColor.kcPrimary
                                          .withValues(alpha: 0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                flagEmoji,
                                style: const TextStyle(fontSize: 24),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  languageName,
                                  style: context.textTheme.titleMedium?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : context.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 22,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
