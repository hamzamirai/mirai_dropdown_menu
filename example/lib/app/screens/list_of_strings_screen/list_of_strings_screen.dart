import 'package:example/app/core/helpers/common_function.dart';
import 'package:example/app/widgets/mirai_dropdown_item_widget.dart';
import 'package:example/app/widgets/mirai_dropdown_list_of_strings_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

/*
* Created By Mirai Devs.
* On 23/6/2022.
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

    /// valueNotifierZero
    valueNotifierZero = ValueNotifier<String>(
      secondListOfItem.first,
    );

    /// valueNotifierFirst
    valueNotifierFirst = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierSecond
    valueNotifierSecond = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierThird
    valueNotifierThird = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierFourth
    valueNotifierFourth = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierFifth
    valueNotifierFifth = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierSixth
    valueNotifierSixth = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierSeventh
    valueNotifierSeventh = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierEighth
    valueNotifierEighth = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierNinth
    valueNotifierNinth = ValueNotifier<String>(
      listOfItem.first,
    );

    /// valueNotifierTenth
    valueNotifierTenth = ValueNotifier<String>(
      listOfItem.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    // bool keyboardIsOpen = !(MediaQuery.of(context).viewInsets.bottom == 0);
    // double keyBoardHeight =  MediaQuery.of(context).viewInsets.bottom;
    // miraiPrint('keyBoardHeight $keyBoardHeight');
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Texts / Strings'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: ListView(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: kIsWeb ? 100 : 20,
        ),
        children: <Widget>[
          Text(
            'Welcome to, \nList Of Texts / Strings screen.',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark,
                ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              firstDropdownGlobalKey.currentState?.showDropDownMenu();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
              minimumSize: const Size(double.infinity, 56),
            ),
            child: Text(
              'Open First Drop Down',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 40),
          const Text('Drop Down'),
          const SizedBox(height: 8),
          MiraiDropdownWidget<String>(
            dropdownKey: firstDropdownGlobalKey,
            valueNotifier: valueNotifierZero,
            // showOtherAndItsTextField: true,
            // showSearchTextField: true,
            otherOnFieldSubmitted: (String value) {
              miraiPrint('otherOnFieldSubmitted $value');
            },
            itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            itemWidgetBuilder: (
              int index,
              String? item, {
              bool isItemSelected = false,
            }) {
              return MiraiDropDownItemWidget(
                item: item,
                isItemSelected: isItemSelected,
              );
            },
            // children: [],
            children: secondListOfItem,
            onChanged: (String value) {
              print('onChanged $value');
              valueNotifierZero.value = value;
            },
          ),
          const SizedBox(height: 16),
          MiraiDropdownWidget<String>(
            valueNotifier: valueNotifierFirst,
            showOtherAndItsTextField: true,
            showSearchTextField: true,
            otherOnFieldSubmitted: (String value) {
              miraiPrint('otherOnFieldSubmitted $value');
            },
            itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            itemWidgetBuilder: (
              int index,
              String? item, {
              bool isItemSelected = false,
            }) {
              return MiraiDropDownItemWidget(
                item: item,
                isItemSelected: isItemSelected,
              );
            },
            // children: [],
            children: listOfItem,
            onChanged: (String value) {
              print('onChanged $value');
              valueNotifierFirst.value = value;
            },
          ),
          const SizedBox(height: 16),
          const Text('Drop Down: 2 items'),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: MiraiDropdownWidget<String>(
                  //  maxHeight: listOfItem.length > 8 ? 300 : null,
                  valueNotifier: valueNotifierSecond,
                  showOtherAndItsTextField: true,
                  other: const Text('Other'),
                  itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
              const SizedBox(width: 8),
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: listOfItem.length > 8 ? 300 : null,
                  valueNotifier: valueNotifierThird,
                  itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
            ],
          ),
          const SizedBox(height: 16),
          const Text('Drop Down: 3 items'),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: listOfItem.length > 6 ? 240 : null,
                  valueNotifier: valueNotifierFourth,
                  itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
              const SizedBox(width: 8),
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: listOfItem.length > 6 ? 240 : null,
                  valueNotifier: valueNotifierFifth,
                  itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
              const SizedBox(width: 8),
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: listOfItem.length > 6 ? 240 : null,
                  valueNotifier: valueNotifierSixth,
                  itemMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
            ],
          ),
          const SizedBox(height: 16),
          const Text('Drop Down: 4 items'),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: MiraiDropdownWidget<String>(
                  showMode: MiraiShowMode.top,
                  valueNotifier: valueNotifierSeventh,
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
              const SizedBox(width: 8),
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: listOfItem.length > 6 ? 160 : null,
                  showMode: kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                  valueNotifier: valueNotifierEighth,
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
              const SizedBox(width: 8),
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: listOfItem.length > 6 ? 160 : null,
                  showMode: kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                  valueNotifier: valueNotifierNinth,
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
              const SizedBox(width: 8),
              Expanded(
                child: MiraiDropdownWidget<String>(
                  maxHeight: 200,
                  showMode: MiraiShowMode.top,
                  valueNotifier: valueNotifierTenth,
                  itemWidgetBuilder: (
                    int index,
                    String? item, {
                    bool isItemSelected = false,
                  }) {
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
            ],
          ),
          const SizedBox(height: 16),
          MiraiDropdownWidget<String>(
            valueNotifier: valueNotifierFirst,
            //showOtherAndItsTextField: true,
            showSearchTextField: true,
            // otherOnFieldSubmitted: (String value) {
            //   print('otherOnFieldSubmitted $value');
            // },
            itemMargin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            itemWidgetBuilder: (
              int index,
              String? item, {
              bool isItemSelected = false,
            }) {
              return MiraiDropDownItemWidget(
                item: item,
                isItemSelected: isItemSelected,
              );
            },
            // children: [],
            children: listOfItem,
            onChanged: (String value) {
              print('onChanged $value');
              valueNotifierFirst.value = value;
            },
          ),
          const SizedBox(height: 100),
          MiraiDropdownWidget<String>(
            valueNotifier: valueNotifierFirst,
            //showOtherAndItsTextField: true,
            showSearchTextField: true,
            // otherOnFieldSubmitted: (String value) {
            //   print('otherOnFieldSubmitted $value');
            // },
            itemWidgetBuilder: (
              int index,
              String? item, {
              bool isItemSelected = false,
            }) {
              return MiraiDropDownItemWidget(
                item: item,
                isItemSelected: isItemSelected,
              );
            },
            // children: [],
            children: listOfItem,
            onChanged: (String value) {
              print('onChanged $value');
              valueNotifierFirst.value = value;
            },
          ),
        ],
      ),
    );
  }
}
