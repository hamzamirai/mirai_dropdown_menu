import 'package:example/app/core/localization/app_language_keys.dart';
import 'package:example/app/core/localization/state/language_notifier.dart';
import 'package:example/app/core/localization/views/language_picker.dart';
import 'package:example/app/core/theme/app_theme.dart';
import 'package:example/app/core/utils/app_extension.dart';
import 'package:example/app/widgets/mirai_dropdown_item_widget.dart';
import 'package:example/app/widgets/mirai_dropdown_list_of_strings_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

/*
* Created By Mirai Devs.
* On 23/6/2022.
* Updated with Modern Portfolio Design & Localization
*/

class ListOfStringScreen extends StatefulWidget {
  const ListOfStringScreen({super.key});

  @override
  State<ListOfStringScreen> createState() => _ListOfStringScreenState();
}

class _ListOfStringScreenState extends State<ListOfStringScreen> {
  final List<String> listOfItem = <String>[
    'Flutter 1',
    'Dart 2',
    'GetX 3',
    'State 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
  ];

  final List<String> secondListOfItem = <String>[
    'Flutter 1',
    'Dart 2',
    'GetX 3',
  ];

  /// Value Notifiers
  late ValueNotifier<String> valueNotifierZero;
  late ValueNotifier<String> valueNotifierFirst;
  late ValueNotifier<String> valueNotifierSecond;
  late ValueNotifier<String> valueNotifierThird;
  late ValueNotifier<String> valueNotifierFourth;
  late ValueNotifier<String> valueNotifierFifth;
  late ValueNotifier<String> valueNotifierSixth;
  late ValueNotifier<String> valueNotifierSeventh;
  late ValueNotifier<String> valueNotifierEighth;
  late ValueNotifier<String> valueNotifierNinth;
  late ValueNotifier<String> valueNotifierTenth;

  GlobalKey<MiraiDropDownMenuState<String?>> firstDropdownGlobalKey =
      GlobalKey<MiraiDropDownMenuState<String?>>();

  @override
  void initState() {
    super.initState();

    valueNotifierZero = ValueNotifier<String>(secondListOfItem.first);
    valueNotifierFirst = ValueNotifier<String>(listOfItem.first);
    valueNotifierSecond = ValueNotifier<String>(listOfItem.first);
    valueNotifierThird = ValueNotifier<String>(listOfItem.first);
    valueNotifierFourth = ValueNotifier<String>(listOfItem.first);
    valueNotifierFifth = ValueNotifier<String>(listOfItem.first);
    valueNotifierSixth = ValueNotifier<String>(listOfItem.first);
    valueNotifierSeventh = ValueNotifier<String>(listOfItem.first);
    valueNotifierEighth = ValueNotifier<String>(listOfItem.first);
    valueNotifierNinth = ValueNotifier<String>(listOfItem.first);
    valueNotifierTenth = ValueNotifier<String>(listOfItem.first);
  }

  @override
  Widget build(BuildContext context) {
    final String currentLangCode =
        LanguageNotifier.instance.currentLocale.languageCode;
    final String currentFlag =
        languageData[currentLangCode]?['flag'] ?? '🌐';

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr(AppLanguagesKeys.stringDropdownsTitleKey)),
        backgroundColor: context.colorScheme.primary,
        elevation: 0,
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
      backgroundColor: context.colorScheme.surfaceContainerHighest,
      resizeToAvoidBottomInset: true,
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: kIsWeb ? 100 : 20,
        ),
        children: <Widget>[
          Text(
            context.tr(AppLanguagesKeys.stringDropdownsHeaderKey),
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkBlueColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            context.tr(AppLanguagesKeys.stringDropdownsSubtitleKey),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          
          // Section 1: Basic Dropdown
          _buildSectionHeader('Basic Dropdown'),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              firstDropdownGlobalKey.currentState?.showDropDownMenu();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.appColor,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Icon(Icons.open_in_full, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Text(
                  'Open Dropdown',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildDropdownCard(
            child: MiraiDropdownWidget<String>(
              dropdownKey: firstDropdownGlobalKey,
              valueNotifier: valueNotifierZero,
              itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                return MiraiDropDownItemWidget(
                  item: item,
                  isItemSelected: isItemSelected,
                );
              },
              children: secondListOfItem,
              onChanged: (String value) {
                valueNotifierZero.value = value;
              },
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Section 2: Searchable Dropdown
          _buildSectionHeader('Searchable with Other Option'),
          const SizedBox(height: 12),
          _buildDropdownCard(
            child: MiraiDropdownWidget<String>(
              valueNotifier: valueNotifierFirst,
              showOtherAndItsTextField: true,
              showSearchTextField: true,
              itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                return MiraiDropDownItemWidget(
                  item: item,
                  isItemSelected: isItemSelected,
                );
              },
              children: listOfItem,
              onChanged: (String value) {
                valueNotifierFirst.value = value;
              },
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Section 3: Two Column Layout
          _buildSectionHeader('Two Column Layout'),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    valueNotifier: valueNotifierSecond,
                    showOtherAndItsTextField: true,
                    other: const Text('Other'),
                    itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierSecond.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: listOfItem.length > 8 ? 300 : null,
                    valueNotifier: valueNotifierThird,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierThird.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Section 4: Three Column Layout
          _buildSectionHeader('Three Column Layout'),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: listOfItem.length > 6 ? 240 : null,
                    valueNotifier: valueNotifierFourth,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierFourth.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: listOfItem.length > 6 ? 240 : null,
                    valueNotifier: valueNotifierFifth,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierFifth.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: listOfItem.length > 6 ? 240 : null,
                    valueNotifier: valueNotifierSixth,
                    itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierSixth.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          // Section 5: Positioning Modes
          _buildSectionHeader('Positioning Modes'),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    showMode: MiraiShowMode.top,
                    valueNotifier: valueNotifierSeventh,
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierSeventh.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: listOfItem.length > 6 ? 160 : null,
                    showMode: kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                    valueNotifier: valueNotifierEighth,
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierEighth.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: listOfItem.length > 6 ? 160 : null,
                    showMode: kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                    valueNotifier: valueNotifierNinth,
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierNinth.value = value;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdownCard(
                  child: MiraiDropdownWidget<String>(
                    maxHeight: 200,
                    showMode: MiraiShowMode.top,
                    valueNotifier: valueNotifierTenth,
                    itemWidgetBuilder: (int index, String? item, {bool isItemSelected = false}) {
                      return MiraiDropDownItemWidget(
                        item: item,
                        isItemSelected: isItemSelected,
                      );
                    },
                    children: listOfItem,
                    onChanged: (String value) {
                      valueNotifierTenth.value = value;
                    },
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDropdownCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.borderColor,
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
      child: child,
    );
  }
}
