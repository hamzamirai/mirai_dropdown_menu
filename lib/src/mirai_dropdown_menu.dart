/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/models/search_attributes_model.dart';
import 'package:mirai_dropdown_menu/src/utils/extensions.dart';
import 'package:mirai_dropdown_menu/src/widgets/item_widget.dart';
import 'package:mirai_dropdown_menu/src/widgets/separator_widget.dart';

import 'utils/common_function.dart';

part 'utils/enums.dart';

typedef MiraiDropdownBuilder<T> = Widget Function(
  int index,
  T? item, {
  bool isItemSelected,
});

typedef MiraiHighLightDropdownBuilder<T> = Widget Function(
  int index,
  SearchAttributes<T> item,
);

typedef MiraiValueChanged<T> = void Function(T value);

class MiraiDropDownMenu<T> extends StatefulWidget {
  MiraiDropDownMenu({
    super.key,
    required this.child,
    this.other,
    this.decoration,
    required this.itemWidgetBuilder,
    this.itemHighLightBuilder,
    required this.children,
    this.valueNotifier,
    this.mode = MiraiPopupMenuMode.dropDownMenu,
    this.showMode = MiraiShowMode.bottom,
    this.onChanged,
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

  /// Drop Down Decoration
  final Decoration? decoration;
  final Widget? other;

  /// itemWidget, is a widget that we display as an item in the list menu
  final MiraiDropdownBuilder<T> itemWidgetBuilder;
  final MiraiHighLightDropdownBuilder<T>? itemHighLightBuilder;

  /// children, is the list that we display in the dropdown
  final List<T> children;

  /// User this valueNotifier to detect which item is Selected...
  final ValueNotifier<T>? valueNotifier;

  /// The max height of the dropdown
  final double? maxHeight;
  final double? radius;

  /// mode, can have two values: dropDownMenu or popupMenu
  final MiraiPopupMenuMode mode;
  final MiraiShowMode showMode;

  final ValueChanged<T>? onChanged;
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
      onTap: widget.enable ? _showDropDownMenu : null,
      child: widget.child,
    );
  }

  void _showDropDownMenu() {
    FocusManager.instance.primaryFocus?.unfocus();

    /// Find RenderBox object
    RenderBox renderBox =
        (widget.child.key as GlobalKey).currentContext?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    if (widget.children.isNotEmpty) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return _DropDownMenuContent<T>(
            maxHeight: widget.maxHeight,
            radius: widget.radius,
            space: widget.space,
            showMode: widget.showMode,
            itemWidgetBuilder: widget.itemWidgetBuilder,
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
            showItemSelectedBackgroundColor: widget.showSelectedItemBackgroundColor,
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
            itemHighLightBuilder: widget.itemHighLightBuilder,
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

class _DropDownMenuContent<T> extends StatefulWidget {
  const _DropDownMenuContent({
    super.key,
    required this.children,
    required this.valueNotifier,
    required this.itemWidgetBuilder,
    required this.itemHighLightBuilder,
    required this.position,
    required this.size,
    required this.mode,
    required this.showMode,
    required this.onChanged,
    required this.maxHeight,
    required this.radius,
    required this.showOtherAndItsTextField,
    required this.showSeparator,
    required this.onOtherChanged,
    required this.exit,
    required this.isExpanded,
    required this.space,
    required this.decoration,

    /// Search
    required this.showSearchTextField,
    required this.searchDecoration,
    required this.searchValidator,
    required this.searchTextFormFieldStyle,

    /// Other
    required this.other,
    required this.otherController,
    required this.otherDecoration,
    required this.otherValidator,
    required this.otherOnFieldSubmitted,
    required this.otherHeight,
    required this.otherMargin,

    ///
    required this.itemPadding,
    required this.itemOverlayColor,
    required this.itemBackgroundColor,
    required this.selectedItemBackgroundColor,
    required this.showItemSelectedBackgroundColor,
    required this.itemMargin,
    required this.itemHeight,
    required this.separatorColor,
    required this.listThumbVisibility,
    required this.animationDuration,
    required this.searchNoDataWidget,
  });

  final List<T> children;
  final ValueNotifier<T>? valueNotifier;
  final MiraiDropdownBuilder<T> itemWidgetBuilder;
  final MiraiHighLightDropdownBuilder<T>? itemHighLightBuilder;
  final Offset position;
  final Size size;
  final ValueChanged<T>? onChanged;
  final MiraiPopupMenuMode mode;
  final MiraiShowMode showMode;
  final double? maxHeight;
  final double? radius;
  final bool showOtherAndItsTextField;
  final bool listThumbVisibility;
  final bool showSeparator;
  final ValueChanged<String>? onOtherChanged;
  final MiraiExit exit;
  final ValueChanged<bool>? isExpanded;
  final double space;
  final Decoration? decoration;
  final Widget? other;

  final bool showSearchTextField;

  final InputDecoration? searchDecoration;
  final FormFieldValidator<String>? searchValidator;
  final TextStyle? searchTextFormFieldStyle;

  final TextEditingController? otherController;
  final InputDecoration? otherDecoration;
  final FormFieldValidator<String>? otherValidator;
  final ValueChanged<String>? otherOnFieldSubmitted;
  final double? otherHeight;
  final EdgeInsetsGeometry? otherMargin;

  final EdgeInsetsGeometry? itemPadding;

  final Color? itemOverlayColor;
  final Color? itemBackgroundColor;
  final Color? selectedItemBackgroundColor;
  final bool showItemSelectedBackgroundColor;
  final EdgeInsetsGeometry? itemMargin;
  final double? itemHeight;

  final Color? separatorColor;

  final Duration? animationDuration;

  final Widget? searchNoDataWidget;

  @override
  _DropDownMenuContentState<T> createState() => _DropDownMenuContentState<T>();
}

class _DropDownMenuContentState<T> extends State<_DropDownMenuContent<T>>
    with SingleTickerProviderStateMixin {
  /// Let's create animation
  late AnimationController _animationController;
  late Animation<double> _animation;

  /// ListView controller
  final ScrollController _scrollController = ScrollController();

  /// Search Children
  ValueNotifier<SearchAttributes<T>> searchChildren = ValueNotifier<SearchAttributes<T>>(
    SearchAttributes<T>(),
  );

  ValueNotifier<bool> onOtherWidgetClicked = ValueNotifier<bool>(false);
  ValueNotifier<bool> isEntirelyOnScreenValueNotifier = ValueNotifier<bool>(false);

  ///  Search Controller
  final TextEditingController searchController = TextEditingController();

  GlobalKey myWidgetKey = GlobalKey();
  late MiraiShowMode newShowMode;

  @override
  void initState() {
    super.initState();

    newShowMode = widget.showMode;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    /// Copy children to searchChildren.value.searchList
    searchChildren.value.searchList = List<T>.from(widget.children);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      isEntirelyOnScreen(myWidgetKey);
      // if (isEntirelyOnScreen(myWidgetKey)) {
      //   miraiPrint("The entire widget is on the screen!");
      // } else {
      //   miraiPrint("The entire widget is not fully visible on the screen!");
      // }
    });
  }

  double? dropHeight;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // MiraiShowMode newShowMode = widget.showMode;
    final Size sizeScreen = MediaQuery.sizeOf(context);
    // dropHeight ??= widget.children.length > 20 ? 300.0 : widget.maxHeight;
    // miraiPrint('widget.maxHeight ${widget.maxHeight}');
    // miraiPrint('dropHeight $dropHeight');
    // // if (dropHeight != null && dropHeight! >= sizeScreen.height) {
    // if (widget.maxHeight == null || !isEntirelyOnScreenValueNotifier.value) {
    //   if (widget.showMode == MiraiShowMode.bottom) {
    //     dropHeight = sizeScreen.height -
    //         widget.position.dy -
    //         widget.size.height -
    //         context.bottomAdding;
    //     miraiPrint('NewDropHeight $dropHeight');
    //   } else {
    //     double appBarHeight = AppBar().preferredSize.height;
    //     dropHeight = widget.position.dy - context.topPadding - appBarHeight - 20;
    //   }
    //
    //   double dropPosition = (dropHeight ?? 0) - widget.position.dy;
    //   dropPosition = dropPosition.abs();
    //   miraiPrint('dropPosition $dropPosition');
    //
    //   if (dropPosition > dropHeight!) {
    //     newShowMode = MiraiShowMode.top;
    //     dropHeight = dropPosition;
    //   }
    // }

    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    bool keyboardIsOpen = !(keyBoardHeight == 0);

    miraiPrint('keyBoardHeight $keyBoardHeight');
    miraiPrint('keyboardIsOpen $keyboardIsOpen');
    if (!keyboardIsOpen) onOtherWidgetClicked.value = false;
    if (keyboardIsOpen && dropHeight != null) {
      double dropRestHeight = sizeScreen.height - widget.position.dy - keyBoardHeight;
      miraiPrint('dropRestHeight $dropRestHeight');

      if (dropRestHeight <= 100) newShowMode = MiraiShowMode.top;

      miraiPrint('1 onOtherWidgetClicked ${onOtherWidgetClicked.value}');

      if (onOtherWidgetClicked.value) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 200),
        );
      }
      miraiPrint('2 onOtherWidgetClicked ${onOtherWidgetClicked.value}');
    }

    return GestureDetector(
      onTap: () => (widget.exit == MiraiExit.fromAll || widget.exit == MiraiExit.outside)
          ? _closePopup(context: context, action: null)
          : null,
      child: Material(
        elevation: 0,
        type: MaterialType.transparency,
        child: Container(
          height: sizeScreen.height,
          width: sizeScreen.width,
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              Positioned(
                right: (sizeScreen.width - widget.position.dx) - widget.size.width,
                top: newShowMode != MiraiShowMode.top
                    ? widget.position.dy + widget.space + widget.size.height
                    : null,
                bottom: newShowMode != MiraiShowMode.bottom
                    ? sizeScreen.height - widget.position.dy + widget.space
                    : null,
                child: SizedBox(
                  width: widget.size.width,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (BuildContext context, Widget? child) {
                      return SizeTransition(
                        sizeFactor: _animationController,
                        child: Opacity(
                          opacity: _animation.value,
                          child: child,
                        ),
                      );
                      // return Transform.scale(
                      //   scale: _animation.value,
                      //   alignment: widget.showMode != MiraiShowMode.top
                      //       ? Alignment.topCenter
                      //       : Alignment.bottomCenter,
                      //   child: Opacity(
                      //     opacity: _animation.value,
                      //     child: child,
                      //   ),
                      // );
                    },
                    child: Container(
                      height: dropHeight ?? widget.maxHeight,
                      width: widget.size.width, // - 1,
                      decoration: widget.decoration ??
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(widget.radius ?? 5),
                            border: Border.all(
                              color: const Color(0xFFCECECE),
                              width: 0.5,
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                      child: LayoutBuilder(
                        key: myWidgetKey,
                        builder: (_, BoxConstraints constraints) {
                          miraiPrint('constraints maxHeight  ${constraints.maxHeight}');
                          return ValueListenableBuilder<SearchAttributes<T>>(
                            valueListenable: searchChildren,
                            builder: (_, SearchAttributes<T> children, __) {
                              final int itemCount = children.searchList.length +
                                  (widget.showOtherAndItsTextField ? 1 : 0) +
                                  (widget.showSearchTextField ? 1 : 0);

                              return Scrollbar(
                                thumbVisibility: widget.listThumbVisibility,
                                controller: _scrollController,
                                radius: const Radius.circular(20),
                                child: ListView.separated(
                                  controller: _scrollController,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(
                                    bottom: keyboardIsOpen ? (keyBoardHeight + 20) : 0,
                                  ),
                                  itemCount: itemCount,
                                  itemBuilder: (_, int index) {
                                    final int newIndex =
                                        widget.showSearchTextField ? index - 1 : index;

                                    final T? searchedItem =
                                        safeGet(children.searchList, newIndex);

                                    if (widget.valueNotifier != null) {
                                      return ValueListenableBuilder<T>(
                                          valueListenable: widget.valueNotifier!,
                                          builder: (_, T value, __) {
                                            return AnimatedSwitcher(
                                              duration: const Duration(milliseconds: 100),
                                              child: SizedBox(
                                                width: widget.size.width,
                                                child: ItemWidget<T>(
                                                  index: index,
                                                  key: ValueKey<String>(value.toString()),
                                                  onTapChild: () => onTapChild(newIndex),
                                                  showOtherAndItsTextField:
                                                      widget.showOtherAndItsTextField,
                                                  showSearchTextField:
                                                      widget.showSearchTextField,
                                                  searchListLength: itemCount,

                                                  /// Search
                                                  searchController: searchController,
                                                  searchDecoration:
                                                      widget.searchDecoration,
                                                  searchValidator: widget.searchValidator,
                                                  searchTextFormFieldStyle:
                                                      widget.searchTextFormFieldStyle,
                                                  onChanged: searchSubscription,

                                                  /// Other
                                                  otherController: widget.otherController,
                                                  otherDecoration:
                                                      widget.searchDecoration,
                                                  otherValidator: widget.searchValidator,
                                                  otherOnFieldSubmitted:
                                                      widget.otherOnFieldSubmitted,
                                                  otherHeight: keyboardIsOpen
                                                      ? (widget.otherHeight ?? 100) * 2
                                                      : widget.otherHeight,
                                                  otherMargin: widget.otherMargin,

                                                  ///
                                                  itemPadding: widget.itemPadding,
                                                  itemOverlayColor:
                                                      widget.itemOverlayColor,
                                                  selectedItemBackgroundColor: value ==
                                                          searchedItem
                                                      ? widget
                                                              .showItemSelectedBackgroundColor
                                                          ? (widget
                                                                  .selectedItemBackgroundColor ??
                                                              Colors.blue)
                                                          : widget.itemBackgroundColor
                                                      : widget.itemBackgroundColor,
                                                  itemHeight: widget.itemHeight,
                                                  radius: widget.radius ?? 5,
                                                  isFirst: index == 0,
                                                  isLast: index == itemCount - 1,
                                                  scrollController: _scrollController,
                                                  onTapOtherTextField: () =>
                                                      onTapOtherTextField(keyboardIsOpen,
                                                          _scrollController),
                                                  itemBackgroundColor:
                                                      widget.itemBackgroundColor,
                                                  searchNoDataWidget:
                                                      widget.searchNoDataWidget,
                                                  itemMargin: value == searchedItem
                                                      ? widget.itemMargin
                                                      : null,
                                                  child: widget.itemWidgetBuilder(
                                                    index,
                                                    searchedItem,
                                                    isItemSelected: value == searchedItem,
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    } else {
                                      return ItemWidget<T>(
                                        index: index,

                                        onTapChild: () => onTapChild(newIndex),
                                        showOtherAndItsTextField:
                                            widget.showOtherAndItsTextField,
                                        showSearchTextField: widget.showSearchTextField,
                                        searchListLength: itemCount,

                                        /// Search
                                        searchController: searchController,
                                        searchDecoration: widget.searchDecoration,
                                        searchValidator: widget.searchValidator,
                                        searchTextFormFieldStyle:
                                            widget.searchTextFormFieldStyle,
                                        onChanged: searchSubscription,

                                        /// Other
                                        otherController: widget.otherController,
                                        otherDecoration: widget.searchDecoration,
                                        otherValidator: widget.searchValidator,
                                        otherOnFieldSubmitted:
                                            widget.otherOnFieldSubmitted,
                                        otherHeight: keyboardIsOpen
                                            ? (widget.otherHeight ?? 100) * 2
                                            : widget.otherHeight,
                                        otherMargin: widget.otherMargin,

                                        ///
                                        itemPadding: widget.itemPadding,
                                        itemOverlayColor: widget.itemOverlayColor,
                                        itemBackgroundColor: widget.itemBackgroundColor,
                                        itemHeight: widget.itemHeight,
                                        radius: widget.radius ?? 5,
                                        isFirst: index == 0,
                                        isLast: index == itemCount - 1,
                                        scrollController: _scrollController,
                                        onTapOtherTextField: () => onTapOtherTextField(
                                            keyboardIsOpen, _scrollController),
                                        selectedItemBackgroundColor:
                                            selectedIndex == newIndex
                                                ? (widget.selectedItemBackgroundColor ??
                                                    Colors.blue)
                                                : null,

                                        itemMargin: selectedIndex == newIndex
                                            ? widget.itemMargin
                                            : null,
                                        searchNoDataWidget: widget.searchNoDataWidget,

                                        child: widget.itemWidgetBuilder(
                                          index,
                                          searchedItem,
                                          isItemSelected: false,
                                        ),
                                      );
                                    }
                                  },
                                  separatorBuilder: (_, int index) {
                                    if (widget.showSeparator) {
                                      return SeparatorWidget(
                                        color: widget.separatorColor,
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   //right: (sizeScreen.width - widget.position.dx) - widget.size.width,
              //   right: 200,
              //   top: newShowMode != MiraiShowMode.top
              //       ? widget.position.dy + widget.space + widget.size.height
              //       : null,
              //   bottom: newShowMode != MiraiShowMode.bottom
              //       ? sizeScreen.height - widget.position.dy + widget.space
              //       : null,
              //   child: Container(
              //     height: dropHeight,
              //     width: 80,
              //     color: Colors.red,
              //   ),
              // ),
              // Positioned(
              //   right: (sizeScreen.width - widget.position.dx) - widget.size.width,
              //   top: widget.position.dy,
              //   // left: 20,
              //
              //   child: Container(
              //     height: 20,
              //     width: widget.size.width,
              //     color: Colors.green,
              //   ),
              // ),
              // Positioned(
              //   // right: (sizeScreen.width - widget.position.dx) - widget.size.width,
              //   top: 0,
              //   left: 300,
              //
              //   child: Container(
              //     height: dropHeight,
              //     width: 80,
              //     color: Colors.purple,
              //     child: Center(
              //       child: Text(
              //         'dropHeight',
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Builder(builder: (context) {
              //   final RenderBox? widgetRenderBox =
              //       myWidgetKey.currentContext?.findRenderObject() as RenderBox?;
              //   if (widgetRenderBox == null) {
              //     //  miraiPrint('No RenderBox found for the widget.');
              //     return const SizedBox();
              //   }
              //
              //   final Offset widgetTopLeft = widgetRenderBox.localToGlobal(Offset.zero);
              //
              //   final Offset widgetBottomRight = Offset(
              //       widgetRenderBox.size.width,
              //       //  screenSize.height - widget.position.dy - widget.size.height - context.bottomAdding
              //       // widgetRenderBox.size.height +
              //       widgetTopLeft.dy
              //       // +  widget.space
              //       //  + widget.size.height
              //       // + context.topPadding
              //       //   + appBarHeight,
              //       );
              //
              //   print('widgetBottomRight.dy ${widgetBottomRight.dy}');
              //   print('widgetRenderBox.size.height ${widgetRenderBox.size.height}');
              //   print('widgetRenderBox.size.height+dy ${widgetBottomRight.dy + widgetRenderBox.size.height}');
              //   return Stack(
              //     children: [
              //       Positioned(
              //         top: 0,
              //         left: 20,
              //         child: Container(
              //           width: 120,
              //           height: widgetBottomRight.dy,
              //           // height: widgetRenderBox.size.height,
              //           color: Colors.green,
              //           child: Center(
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 'I am positioned to top-left!\n drop-top-lef: ${widgetBottomRight.dy}',
              //                 style: TextStyle(color: Colors.white),textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         top: widgetBottomRight.dy,
              //         left: 140,
              //         child: Container(
              //           width: 120,
              //           //  height: widgetBottomRight.dy,
              //           height: widgetRenderBox.size.height,
              //           color: Colors.red,
              //           child: Center(
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 'I am positioned from top-left to bottom-left!\n drop-height: ${widgetRenderBox.size.height}',
              //                 style: TextStyle(color: Colors.white),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         top: widgetBottomRight.dy + widgetRenderBox.size.height,
              //         left: 260,
              //         child: Container(
              //           width: 120,
              //           //  height: widgetBottomRight.dy,
              //           height: widgetRenderBox.size.height,
              //           color: Colors.purple,
              //           child: Center(
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 'I am positioned from bottom-left to drop-height!\n ${widgetRenderBox.size.height}',
              //                 style: TextStyle(color: Colors.white),
              //                 textAlign: TextAlign.center,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   );
              // })
            ],
          ),
        ),
      ),
    );
  }

  void onTapOtherTextField(bool isKeyboardVisible, ScrollController scrollController) {
    miraiPrint('onTapOtherTextField');
    onOtherWidgetClicked.value = true;
  }

  void _closePopup({required BuildContext context, required T? action}) async {
    FocusManager.instance.primaryFocus?.unfocus();

    widget.isExpanded?.call(false);
    if (action != null) widget.onChanged?.call(action);
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _animationController.reverse().whenComplete(() {
      Navigator.pop(context);
    });
  }

  void onTapChild(int index) {
    if (widget.exit == MiraiExit.fromAll || widget.exit == MiraiExit.inside) {
      _closePopup(
        context: context,
        action: searchChildren.value.searchList[index],
      );
    } else {
      widget.onChanged?.call(searchChildren.value.searchList[index]);
    }
    setState(() => selectedIndex = index);
  }

  void clearTextController() {
    searchController.clear();
    searchChildren.value.showHighLight = true;
    searchChildren.value.mQueryClient = '';
    searchChildren.value.searchList = List<T>.from(widget.children);
  }

  void searchSubscription(String query) {
    SearchAttributes<T> searchAttributes = SearchAttributes<T>();
    if (query.isNotEmpty) {
      searchAttributes.showHighLight = true;
      searchAttributes.mQueryClient = query;

      final Iterable<T> results = widget.children.where((T child) =>
          ((child is String) ? child : child.toString()).toLowerCase().contains(query));
      searchAttributes.searchList = List<T>.from(results);
    } else {
      searchAttributes.showHighLight = false;
      searchAttributes.mQueryClient = '';
      searchAttributes.searchList = List<T>.from(widget.children);
    }
    searchChildren.value = searchAttributes;
  }

  bool isBottomOnScreen(GlobalKey key) {
    final RenderBox widgetRenderBox = key.currentContext?.findRenderObject() as RenderBox;
    final Offset widgetPosition = widgetRenderBox.localToGlobal(Offset.zero);
    final Size widgetSize = widgetRenderBox.size;

    // Get the screen size
    final Size screenSize = MediaQuery.of(key.currentContext!).size;

    // Check the position and size of the widget against the screen size
    bool isBottomOnScreen = widgetPosition.dy + widgetSize.height <= screenSize.height;

    return isBottomOnScreen;
  }

  bool isEntirelyOnScreen(GlobalKey key) {
    final RenderBox? widgetRenderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (widgetRenderBox == null) {
      //  miraiPrint('No RenderBox found for the widget.');
      return false;
    }

    // Get the screen size
    final Size screenSize = MediaQuery.sizeOf(key.currentContext!);
    final EdgeInsets padding = MediaQuery.paddingOf(key.currentContext!);

    double appBarHeight = AppBar().preferredSize.height;

    final Offset widgetTopLeft = widgetRenderBox.localToGlobal(Offset.zero);

    final Offset widgetBottomRight =
        Offset(widgetRenderBox.size.width, widgetRenderBox.size.height + widgetTopLeft.dy
            // +
            //     widget.space +
            //     widget.size.height +
            //     context.topPadding +
            //     appBarHeight,
            );

    // showContainer(widgetBottomRight, widgetRenderBox.size.height);

    // Check the position and size of the widget against the screen size
    bool isEntirelyOnScreen =
        // widgetTopLeft.dx >= 0 &&
        // widgetTopLeft.dy >= 0 &&
        // widgetBottomRight.dx <= screenSize.width &&
        (widgetBottomRight.dy + widgetRenderBox.size.height) <= screenSize.height;

    miraiPrint('isEntirelyOnScreen $isEntirelyOnScreen');
    miraiPrint('widgetRenderBox.size.height dx ${widgetRenderBox.size.height}');
    miraiPrint('widgetTopLeft dx ${widgetTopLeft.dx}');
    miraiPrint('widgetTopLeft dy ${widgetTopLeft.dy}');
    miraiPrint('widgetBottomRight dx ${widgetBottomRight.dx}');
    miraiPrint('widgetBottomRight dy ${widgetBottomRight.dy}');
    miraiPrint('screenSize width ${screenSize.width}');
    miraiPrint('screenSize height ${screenSize.height}');
    //

    miraiPrint('widgetTopLeft: $widgetTopLeft');
    miraiPrint('widgetBottomRight: $widgetBottomRight');
    miraiPrint('screenSize: $screenSize');
    miraiPrint('padding: $padding');

    miraiPrint('Rest: ${widgetBottomRight.dy - screenSize.height}');
    final double rest = widgetBottomRight.dy - screenSize.height;

    if (!isEntirelyOnScreen) {
      // setState(() {
      //   dropHeight =
      //       widgetRenderBox.size.height - rest - widget.size.height - widget.space;
      //   miraiPrint('dropHeight: $dropHeight');
      // });

      final Size sizeScreen = MediaQuery.sizeOf(context);
      dropHeight ??= widget.children.length > 20 ? 300.0 : widget.maxHeight;
      miraiPrint('widget.maxHeight ${widget.maxHeight}');
      miraiPrint('dropHeight $dropHeight');
      // if (dropHeight != null && dropHeight! >= sizeScreen.height) {
      if (widget.maxHeight == null || !isEntirelyOnScreenValueNotifier.value) {
        if (widget.showMode == MiraiShowMode.bottom) {
          dropHeight = sizeScreen.height -
              widget.position.dy -
              widget.size.height -
              context.bottomAdding;
          miraiPrint('NewDropHeight $dropHeight');
        } else {
          double appBarHeight = AppBar().preferredSize.height;
          dropHeight = widget.position.dy - context.topPadding - appBarHeight - 20;
        }

        double dropPosition = (dropHeight ?? 0) - widget.position.dy;
        dropPosition = dropPosition.abs();
        miraiPrint('dropPosition $dropPosition');

        if (dropPosition > dropHeight!) {
          newShowMode = MiraiShowMode.top;
          dropHeight = dropPosition;
        }
      }

      if (widget.maxHeight != null) {
        dropHeight = widget.maxHeight;
      }
      setState(() {});
    } else {
      dropHeight = null;

      if (widget.maxHeight != null) {
        dropHeight = widget.maxHeight;
      }
    }

    isEntirelyOnScreenValueNotifier.value = isEntirelyOnScreen;
    miraiPrint(
        'isEntirelyOnScreenValueNotifier: ${isEntirelyOnScreenValueNotifier.value}');

    return isEntirelyOnScreen;
  }

  void showContainer(Offset bottomLeft, double height) {
    // Use the Stack widget as the root
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            // Use Positioned widget to position the container at the bottom-left offset
            Positioned(
              left: 0,
              top: bottomLeft.dy,
              child: Container(
                width: 150,
                height: height,
                color: Colors.green,
                child: const Center(
                  child: Text(
                    'I am positioned at bottom-left!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
