import 'package:example/app/widgets/mirai_drop_down_item_widget.dart';
import 'package:example/app/widgets/mirai_dropdown_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

/*
* Created By Mirai Devs.
* On 23/6/2022.
*/

class ListOfStringScreen extends StatefulWidget {
  const ListOfStringScreen({Key? key}) : super(key: key);

  @override
  State<ListOfStringScreen> createState() => _ListOfStringScreenState();
}

class _ListOfStringScreenState extends State<ListOfStringScreen> {
  final List<String> listOfItem = <String>[
    'Flutter',
    'Dart',
    'GetX',
    'State',
  ];

  late ValueNotifier<String> valueNotifier;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier<String>(
      listOfItem.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Of Texts/Strings'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kIsWeb ? 100 : 14,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Drop Down'),
              const SizedBox(height: 8),
              MiraiDropdownWidget(
                valueNotifier: valueNotifier,
                itemWidget: (int index, String item) {
                  return MiraiDropDownItemWidget(item: item);
                },
                children: listOfItem,
                onChanged: (String value) {
                  valueNotifier.value = value;
                },
              ),
              const SizedBox(height: 16),
              const Text('Drop Down: 2 items'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: MiraiDropdownWidget(
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MiraiDropdownWidget(
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Drop Down: 3 items'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: MiraiDropdownWidget(
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MiraiDropdownWidget(
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MiraiDropdownWidget(
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Drop Down: 4 items'),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: MiraiDropdownWidget(
                      showMode:
                          kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MiraiDropdownWidget(
                      showMode:
                          kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MiraiDropdownWidget(
                      showMode:
                          kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MiraiDropdownWidget(
                      showMode:
                          kIsWeb ? MiraiShowMode.top : MiraiShowMode.bottom,
                      valueNotifier: valueNotifier,
                      itemWidget: (int index, String item) {
                        return MiraiDropDownItemWidget(item: item);
                      },
                      children: listOfItem,
                      onChanged: (String value) {
                        valueNotifier.value = value;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
