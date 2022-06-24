/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:example/app/core/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

class MiraiDropdownWidget<T> extends StatelessWidget {
  const MiraiDropdownWidget({
    Key? key,
    required this.valueNotifier,
    required this.itemWidget,
    required this.children,
    required this.onChanged,
    this.underline = false,
    this.showSeparator = true,
    this.exit = MiraiExit.fromAll,
    this.chevronDownColor,
    this.dropdownChild,
    this.showMode = MiraiShowMode.bottom,
    this.maxHeight,
  }) : super(key: key);

  final ValueNotifier<String> valueNotifier;
  final MiraiDropdownBuilder<T> itemWidget;
  final List<T> children;
  final ValueChanged<T> onChanged;
  final bool underline;
  final bool showSeparator;
  final MiraiExit exit;
  final Color? chevronDownColor;
  final Widget? dropdownChild;
  final MiraiShowMode showMode;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    return MiraiPopupMenu<T>(
      key: UniqueKey(),
      enable: true,
      space: 4,
      showMode: showMode,
      exit: exit,
      showSeparator: showSeparator,
      children: children,
      itemWidget: itemWidget,
      onChanged: onChanged,
      maxHeight: maxHeight,
      child: Container(
        key: GlobalKey(),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
        ),
        decoration: BoxDecoration(
          borderRadius: underline ? null : BorderRadius.circular(5.0),
          border: underline
              ? const Border(
                  bottom: BorderSide(
                    width: 1.0,
                    color: Colors.blueGrey,
                  ),
                )
              : Border.all(
                  color: Colors.blueGrey,
                  width: 1.0,
                ),
        ),
        height: 40,
        child: dropdownChild ??
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: ValueListenableBuilder<String>(
                    valueListenable: valueNotifier,
                    builder: (_, String chosenTitle, __) {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          chosenTitle,
                          key: ValueKey<String>(chosenTitle.trim()),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                FaIcon(
                  FontAwesomeIcons.chevronDown,
                  color: chevronDownColor ?? AppTheme.keyAppColor,
                  size: 12,
                ),
              ],
            ),
      ),
    );
  }
}
