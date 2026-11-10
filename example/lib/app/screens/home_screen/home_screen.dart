/*
* Created By Mirai Devs.
* On 23/6/2022.
* Updated with Modern Design & Localization
*/

import 'package:flutter/material.dart';

import '../../core/helpers/common_function.dart';
import '../../core/localization/app_language_keys.dart';
import '../../core/localization/state/language_notifier.dart';
import '../../core/localization/views/language_picker.dart';
import '../../core/theme/app_color.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/app_extension.dart';
import '../list_of_objects_screen/list_of_objects_screen.dart';
import '../list_of_strings_screen/list_of_strings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    miraiPrint('Screen height ${size.height}');
    miraiPrint('Screen width ${size.width}');

    final String currentLangCode =
        LanguageNotifier.instance.currentLocale.languageCode;
    final String currentFlag =
        languageData[currentLangCode]?['flag'] ?? '🌐';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.tr(AppLanguagesKeys.appNameKey),
          textAlign: TextAlign.center,
          style: context.textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: context.colorScheme.primary,
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: InkWell(
              onTap: () => ChangeLanguage.showSheet(context),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      currentFlag,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surfaceContainerHighest,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Header Section
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppTheme.gradientPrimary,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColor.kcPrimary.withValues(alpha: 0.2),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.tr(AppLanguagesKeys.welcomeToKey),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        context.tr(AppLanguagesKeys.appNameKey),
                        style: context.textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 3,
                        width: 60,
                        decoration: BoxDecoration(
                          color: AppColor.kcSecondary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Description Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: context.colorScheme.outline,
                      width: 1,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        context.tr(AppLanguagesKeys.aboutPackageKey),
                        style: context.textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.tr(AppLanguagesKeys.aboutPackageDescKey),
                        style: context.textTheme.bodyMedium?.copyWith(
                          height: 1.6,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Feature Highlights
                Text(
                  context.tr(AppLanguagesKeys.featuresKey),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _buildFeatureItem(
                  context,
                  icon: Icons.search,
                  title: context.tr(AppLanguagesKeys.searchableKey),
                  description:
                      context.tr(AppLanguagesKeys.searchableDescKey),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  context,
                  icon: Icons.list,
                  title: context.tr(AppLanguagesKeys.flexibleListsKey),
                  description:
                      context.tr(AppLanguagesKeys.flexibleListsDescKey),
                ),
                const SizedBox(height: 12),
                _buildFeatureItem(
                  context,
                  icon: Icons.api,
                  title: context.tr(AppLanguagesKeys.apiReadyKey),
                  description: context.tr(AppLanguagesKeys.apiReadyDescKey),
                ),

                const SizedBox(height: 32),

                // Action Buttons
                Text(
                  context.tr(AppLanguagesKeys.tryItOutKey),
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _buildActionButton(
                  context,
                  label: context.tr(AppLanguagesKeys.listOfStringsKey),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ListOfStringScreen(),
                      ),
                    );
                  },
                  isPrimary: true,
                ),
                const SizedBox(height: 12),
                _buildActionButton(
                  context,
                  label: context.tr(AppLanguagesKeys.listOfObjectsKey),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const ListObjectsScreen(),
                      ),
                    );
                  },
                  isPrimary: false,
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.colorScheme.outline,
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  AppColor.kcPrimary.withValues(alpha: 0.15),
                  AppColor.kcSecondary.withValues(alpha: 0.15),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColor.kcPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    required bool isPrimary,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: isPrimary ? AppTheme.gradientPrimary : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isPrimary
            ? <BoxShadow>[
                BoxShadow(
                  color: AppColor.kcPrimary.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
        border: !isPrimary
            ? Border.all(
                color: AppColor.kcPrimary.withValues(alpha: 0.3),
                width: 2,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  label,
                  style: context.textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    color: isPrimary ? Colors.white : AppColor.kcPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (isPrimary) ...<Widget>[
                  const SizedBox(width: 8),
                  Icon(
                    context.isRtl
                        ? Icons.arrow_back_rounded
                        : Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
