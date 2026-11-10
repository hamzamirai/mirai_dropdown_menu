import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/utils/extensions.dart';
import 'package:mirai_dropdown_menu/src/widgets/dropdown_menu_content.dart';

part 'utils/enums.dart';

typedef MiraiDropdownBuilder<T> =
    Widget Function(int index, T? item, {bool isItemSelected});

typedef MiraiHighLightDropdownBuilder<T> =
    Widget Function(int index, T? item, String query, {bool isItemSelected});

typedef MiraiValueChanged<T> = void Function(T value);

class MiraiDropDownMenu<T> extends StatefulWidget {
  MiraiDropDownMenu({
    super.key,
    required this.child,
    this.isKeyboardOpen = false,
    this.other,
    this.decoration,
    required this.itemWidgetBuilder,
    this.itemHighLightBuilder,
    required this.children,
    this.valueNotifier,
    this.isMultiSelection = false,
    this.selectedItemsNotifier,
    this.mode = MiraiPopupMenuMode.dropDownMenu,
    this.showMode = MiraiShowMode.bottom,
    this.onChanged,
    this.onMultiChanged,
    this.maxHeight,
    this.radius,
    this.enable = true,
    this.showSeparator = true,
    this.listThumbVisibility = true,
    this.showOtherAndItsTextField = false,
    this.onOtherChanged,
    this.exit = MiraiExit.fromAll,
    this.isExpanded,
    this.space = 3,
    this.emptyListMessage,
    this.showSearchTextField = false,
    this.searchDecoration,
    this.searchValidator,
    this.searchTextFormFieldStyle,
    this.itemPadding,
    this.itemOverlayColor,
    this.itemBackgroundColor,
    this.selectedItemBackgroundColor,
    this.showSelectedItemBackgroundColor = true,
    this.itemMargin,
    this.itemHeight,
    this.separatorColor,

    /// Other
    this.otherController,
    this.otherDecoration,
    this.otherValidator,
    this.otherOnFieldSubmitted,
    this.otherHeight,
    this.otherMargin,
    this.animationDuration,
    this.searchNoDataWidget,
  }) : assert(child.key != null);

  /// Child widget that has dropdown menu
  final Widget child;
  final bool isKeyboardOpen;

  /// Drop Down Decoration
  final Decoration? decoration;
  final Widget? other;

  /// itemWidget, is a widget that we display as an item in the list menu
  final MiraiDropdownBuilder<T> itemWidgetBuilder;

  /// itemHighLightBuilder, used to highlight the search query in the item
  final MiraiHighLightDropdownBuilder<T>? itemHighLightBuilder;

  /// children, is the list that we display in the dropdown
  final List<T> children;

  /// User this valueNotifier to detect which item is Selected...
  final ValueNotifier<T>? valueNotifier;

  /// Whether to allow multi-selection
  final bool isMultiSelection;

  /// User this valueNotifier to detect which items are selected when in multi-selection mode
  final ValueNotifier<List<T>>? selectedItemsNotifier;

  /// The max height of the dropdown
  final double? maxHeight;
  final double? radius;

  /// mode, can have two values: dropDownMenu or popupMenu
  final MiraiPopupMenuMode mode;
  final MiraiShowMode showMode;

  final ValueChanged<T>? onChanged;
  final ValueChanged<List<T>>? onMultiChanged;
  final MiraiExit exit;
  final ValueChanged<bool>? isExpanded;
  final bool enable;
  final bool showSeparator;
  final bool showOtherAndItsTextField;
  final ValueChanged<String>? onOtherChanged;

  /// Space between dropdown and child
  final double space;

  final String? emptyListMessage;

  final bool showSearchTextField;
  final InputDecoration? searchDecoration;
  final FormFieldValidator<String>? searchValidator;
  final TextStyle? searchTextFormFieldStyle;

  final EdgeInsetsGeometry? itemPadding;

  final Color? itemOverlayColor;
  final Color? itemBackgroundColor;
  final Color? selectedItemBackgroundColor;
  final bool showSelectedItemBackgroundColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemMargin;

  final Color? separatorColor;
  final bool listThumbVisibility;

  /// Other
  final TextEditingController? otherController;
  final InputDecoration? otherDecoration;
  final FormFieldValidator<String>? otherValidator;
  final ValueChanged<String>? otherOnFieldSubmitted;
  final double? otherHeight;
  final EdgeInsetsGeometry? otherMargin;

  final Duration? animationDuration;
  final Widget? searchNoDataWidget;

  @override
  MiraiDropDownMenuState<T> createState() => MiraiDropDownMenuState<T>();
}

class MiraiDropDownMenuState<T> extends State<MiraiDropDownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enable
          ? () async {
              if (widget.isKeyboardOpen) {
                FocusManager.instance.primaryFocus?.unfocus();

                await 500.waitForMilliseconds();
                showDropDownMenu();
              } else {
                showDropDownMenu();
              }
            }
          : null,
      child: widget.child,
    );
  }

  void showDropDownMenu() {
    /// Find RenderBox object
    final RenderBox renderBox =
        (widget.child.key as GlobalKey).currentContext?.findRenderObject()
            as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    if (widget.children.isNotEmpty) {
      showCupertinoDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return DropDownMenuContent<T>(
            maxHeight: widget.maxHeight,
            radius: widget.radius,
            space: widget.space,
            showMode: widget.showMode,
            itemWidgetBuilder: widget.itemWidgetBuilder,
            itemHighLightBuilder: widget.itemHighLightBuilder,
            isMultiSelection: widget.isMultiSelection,
            selectedItemsNotifier: widget.selectedItemsNotifier,
            onMultiChanged: widget.onMultiChanged,
            mode: widget.mode,
            position: position,
            size: renderBox.size,
            onChanged: widget.onChanged,
            children: widget.children,
            valueNotifier: widget.valueNotifier,
            decoration: widget.decoration,
            exit: widget.exit,
            isExpanded: widget.isExpanded,
            showOtherAndItsTextField: widget.showOtherAndItsTextField,
            showSeparator: widget.showSeparator,

            /// Search
            showSearchTextField: widget.showSearchTextField,
            searchDecoration: widget.searchDecoration,
            searchValidator: widget.searchValidator,
            searchTextFormFieldStyle: widget.searchTextFormFieldStyle,

            itemPadding: widget.itemPadding,
            itemOverlayColor: widget.itemOverlayColor,
            selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
            itemBackgroundColor: widget.itemBackgroundColor,
            showItemSelectedBackgroundColor:
                widget.showSelectedItemBackgroundColor,
            itemMargin: widget.itemMargin,
            itemHeight: widget.itemHeight,
            separatorColor: widget.separatorColor,
            listThumbVisibility: widget.listThumbVisibility,

            /// Other
            onOtherChanged: widget.onOtherChanged,
            otherController: widget.otherController,
            otherDecoration: widget.otherDecoration,
            otherValidator: widget.otherValidator,
            otherOnFieldSubmitted: widget.otherOnFieldSubmitted,
            otherHeight: widget.otherHeight,
            otherMargin: widget.otherMargin,
            other: widget.other,
            animationDuration: widget.animationDuration,
            searchNoDataWidget: widget.searchNoDataWidget,
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.emptyListMessage ?? 'MiraiDropDown: Empty Children!',
          ),
        ),
      );
    }
  }
}
