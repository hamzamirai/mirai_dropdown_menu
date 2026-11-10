import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/models/search_attributes_model.dart';
import 'package:mirai_dropdown_menu/src/utils/extensions.dart';
import 'package:mirai_dropdown_menu/src/widgets/item_widget.dart';
import 'package:mirai_dropdown_menu/src/widgets/separator_widget.dart';

import '../mirai_dropdown_menu.dart';
import '../utils/common_function.dart';

class DropDownMenuContent<T> extends StatefulWidget {
  const DropDownMenuContent({
    super.key,
    required this.children,
    required this.valueNotifier,
    required this.itemWidgetBuilder,
    this.itemHighLightBuilder,
    required this.isMultiSelection,
    this.selectedItemsNotifier,
    required this.position,
    required this.size,
    required this.mode,
    required this.showMode,
    required this.onChanged,
    this.onMultiChanged,
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

  final bool isMultiSelection;
  final ValueNotifier<List<T>>? selectedItemsNotifier;

  final Offset position;
  final Size size;
  final ValueChanged<T>? onChanged;
  final ValueChanged<List<T>>? onMultiChanged;
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
  DropDownMenuContentState<T> createState() => DropDownMenuContentState<T>();
}

class DropDownMenuContentState<T> extends State<DropDownMenuContent<T>>
    with SingleTickerProviderStateMixin {
  /// Let's create animation
  late AnimationController _animationController;
  late Animation<double> _animation;

  /// ListView controller
  final ScrollController _scrollController = ScrollController();

  /// Search Children
  final ValueNotifier<SearchAttributes<T>> searchChildren =
      ValueNotifier<SearchAttributes<T>>(SearchAttributes<T>());

  final ValueNotifier<bool> onOtherWidgetClicked = ValueNotifier<bool>(false);
  final ValueNotifier<bool> isEntirelyOnScreenValueNotifier =
      ValueNotifier<bool>(false);

  ///  Search Controller
  final TextEditingController searchController = TextEditingController();

  final GlobalKey myWidgetKey = GlobalKey();
  late MiraiShowMode newShowMode;

  List<T> selectedItems = <T>[];

  @override
  void initState() {
    super.initState();

    newShowMode = widget.showMode;
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    /// Copy children to searchChildren.value.searchList
    searchChildren.value.searchList = List<T>.from(widget.children);

    if (widget.isMultiSelection) {
      selectedItems = List<T>.from(widget.selectedItemsNotifier?.value ?? <T>[]);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
      isEntirelyOnScreen(myWidgetKey);
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
    final Size sizeScreen = MediaQuery.sizeOf(context);

    double keyBoardHeight = MediaQuery.of(context).viewInsets.bottom;
    bool keyboardIsOpen = !(keyBoardHeight == 0);

    if (!keyboardIsOpen) onOtherWidgetClicked.value = false;
    if (keyboardIsOpen && dropHeight != null) {
      double dropRestHeight =
          sizeScreen.height - widget.position.dy - keyBoardHeight;

      if (dropRestHeight <= 100) newShowMode = MiraiShowMode.top;

      if (onOtherWidgetClicked.value) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 200),
        );
      }
    }

    return GestureDetector(
      onTap: () =>
          (widget.exit == MiraiExit.fromAll || widget.exit == MiraiExit.outside)
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
                right:
                    (sizeScreen.width - widget.position.dx) - widget.size.width,
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
                        child: Opacity(opacity: _animation.value, child: child),
                      );
                    },
                    child: Container(
                      height: dropHeight ?? widget.maxHeight,
                      width: widget.size.width, // - 1,
                      decoration:
                          widget.decoration ??
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              widget.radius ?? 5,
                            ),
                            border: Border.all(
                              color: const Color(0xFFCECECE),
                              width: 0.5,
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                      child: LayoutBuilder(
                        key: myWidgetKey,
                        builder: (_, BoxConstraints constraints) {
                          return ValueListenableBuilder<SearchAttributes<T>>(
                            valueListenable: searchChildren,
                            builder: (_, SearchAttributes<T> children, _) {
                              final int itemCount =
                                  children.searchList.length +
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
                                    bottom: keyboardIsOpen
                                        ? (keyBoardHeight + 20)
                                        : 0,
                                  ),
                                  itemCount: itemCount,
                                  itemBuilder: (_, int index) {
                                    final int newIndex =
                                        widget.showSearchTextField
                                        ? index - 1
                                        : index;

                                    final T? searchedItem = safeGet(
                                      children.searchList,
                                      newIndex,
                                    );

                                    if (widget.valueNotifier != null) {
                                      return ValueListenableBuilder<T>(
                                        valueListenable: widget.valueNotifier!,
                                        builder: (_, T value, _) {
                                          return AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 100,
                                            ),
                                            child: SizedBox(
                                              width: widget.size.width,
                                              child: ItemWidget<T>(
                                                index: index,
                                                key: ValueKey<String>(
                                                  value.toString(),
                                                ),
                                                onTapChild: () =>
                                                    onTapChild(newIndex),
                                                showOtherAndItsTextField: widget
                                                    .showOtherAndItsTextField,
                                                showSearchTextField:
                                                    widget.showSearchTextField,
                                                searchListLength: itemCount,

                                                /// Search
                                                searchController:
                                                    searchController,
                                                searchDecoration:
                                                    widget.searchDecoration,
                                                searchValidator:
                                                    widget.searchValidator,
                                                searchTextFormFieldStyle: widget
                                                    .searchTextFormFieldStyle,
                                                onChanged: searchSubscription,

                                                /// Other
                                                otherController:
                                                    widget.otherController,
                                                otherDecoration:
                                                    widget.searchDecoration,
                                                otherValidator:
                                                    widget.searchValidator,
                                                otherOnFieldSubmitted: widget
                                                    .otherOnFieldSubmitted,
                                                otherHeight: keyboardIsOpen
                                                    ? (widget.otherHeight ??
                                                              100) *
                                                          2
                                                    : widget.otherHeight,
                                                otherMargin: widget.otherMargin,

                                                ///
                                                itemPadding: widget.itemPadding,
                                                itemOverlayColor:
                                                    widget.itemOverlayColor,
                                                selectedItemBackgroundColor:
                                                    (widget.isMultiSelection
                                                        ? selectedItems
                                                              .contains(
                                                                searchedItem,
                                                              )
                                                        : value == searchedItem)
                                                    ? widget.showItemSelectedBackgroundColor
                                                          ? (widget.selectedItemBackgroundColor ??
                                                                Colors.blue)
                                                          : widget
                                                                .itemBackgroundColor
                                                    : widget
                                                          .itemBackgroundColor,
                                                itemHeight: widget.itemHeight,
                                                radius: widget.radius ?? 5,
                                                isFirst: index == 0,
                                                isLast: index == itemCount - 1,
                                                scrollController:
                                                    _scrollController,
                                                onTapOtherTextField: () =>
                                                    onTapOtherTextField(
                                                      keyboardIsOpen,
                                                      _scrollController,
                                                    ),
                                                itemBackgroundColor:
                                                    widget.itemBackgroundColor,
                                                searchNoDataWidget:
                                                    widget.searchNoDataWidget,
                                                itemMargin:
                                                    (widget.isMultiSelection
                                                        ? selectedItems
                                                              .contains(
                                                                searchedItem,
                                                              )
                                                        : value == searchedItem)
                                                    ? widget.itemMargin
                                                    : null,
                                                child:
                                                    children.showHighLight &&
                                                        widget.itemHighLightBuilder !=
                                                            null
                                                    ? widget
                                                          .itemHighLightBuilder!(
                                                        index,
                                                        searchedItem,
                                                        children.mQueryClient,
                                                        isItemSelected:
                                                            widget
                                                                .isMultiSelection
                                                            ? selectedItems
                                                                  .contains(
                                                                    searchedItem,
                                                                  )
                                                            : value ==
                                                                  searchedItem,
                                                      )
                                                    : widget.itemWidgetBuilder(
                                                        index,
                                                        searchedItem,
                                                        isItemSelected:
                                                            widget
                                                                .isMultiSelection
                                                            ? selectedItems
                                                                  .contains(
                                                                    searchedItem,
                                                                  )
                                                            : value ==
                                                                  searchedItem,
                                                      ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else {
                                      return ItemWidget<T>(
                                        index: index,

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
                                        itemBackgroundColor:
                                            widget.itemBackgroundColor,
                                        itemHeight: widget.itemHeight,
                                        radius: widget.radius ?? 5,
                                        isFirst: index == 0,
                                        isLast: index == itemCount - 1,
                                        scrollController: _scrollController,
                                        onTapOtherTextField: () =>
                                            onTapOtherTextField(
                                              keyboardIsOpen,
                                              _scrollController,
                                            ),
                                        selectedItemBackgroundColor:
                                            (widget.isMultiSelection
                                                ? selectedItems.contains(
                                                    searchedItem,
                                                  )
                                                : selectedIndex == newIndex)
                                            ? (widget.selectedItemBackgroundColor ??
                                                  Colors.blue)
                                            : null,
                                        itemMargin:
                                            (widget.isMultiSelection
                                                ? selectedItems.contains(
                                                    searchedItem,
                                                  )
                                                : selectedIndex == newIndex)
                                            ? widget.itemMargin
                                            : null,
                                        searchNoDataWidget:
                                            widget.searchNoDataWidget,
                                        child:
                                            children.showHighLight &&
                                                widget.itemHighLightBuilder !=
                                                    null
                                            ? widget.itemHighLightBuilder!(
                                                index,
                                                searchedItem,
                                                children.mQueryClient,
                                                isItemSelected:
                                                    widget.isMultiSelection
                                                    ? selectedItems.contains(
                                                        searchedItem,
                                                      )
                                                    : selectedIndex == newIndex,
                                              )
                                            : widget.itemWidgetBuilder(
                                                index,
                                                searchedItem,
                                                isItemSelected:
                                                    widget.isMultiSelection
                                                    ? selectedItems.contains(
                                                        searchedItem,
                                                      )
                                                    : selectedIndex == newIndex,
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
            ],
          ),
        ),
      ),
    );
  }

  void onTapOtherTextField(
    bool isKeyboardVisible,
    ScrollController scrollController,
  ) {
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
    if (widget.isMultiSelection) {
      final T item = searchChildren.value.searchList[index];
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
      widget.selectedItemsNotifier?.value = List<T>.from(selectedItems);
      widget.onMultiChanged?.call(selectedItems);
      setState(() => selectedIndex = index);

      if (widget.exit == MiraiExit.fromAll) {
        _closePopup(context: context, action: null);
      }
    } else {
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

      final Iterable<T> results = widget.children.where(
        (T child) => ((child is String) ? child : child.toString())
            .toLowerCase()
            .contains(query.toLowerCase()),
      );
      searchAttributes.searchList = List<T>.from(results);
    } else {
      searchAttributes.showHighLight = false;
      searchAttributes.mQueryClient = '';
      searchAttributes.searchList = List<T>.from(widget.children);
    }
    searchChildren.value = searchAttributes;
  }

  bool isBottomOnScreen(GlobalKey key) {
    final RenderBox widgetRenderBox =
        key.currentContext?.findRenderObject() as RenderBox;
    final Offset widgetPosition = widgetRenderBox.localToGlobal(Offset.zero);
    final Size widgetSize = widgetRenderBox.size;

    // Get the screen size
    final Size screenSize = MediaQuery.of(key.currentContext!).size;

    // Check the position and size of the widget against the screen size
    bool isBottomOnScreen =
        widgetPosition.dy + widgetSize.height <= screenSize.height;

    return isBottomOnScreen;
  }

  bool isEntirelyOnScreen(GlobalKey key) {
    final RenderBox? widgetRenderBox =
        key.currentContext?.findRenderObject() as RenderBox?;
    if (widgetRenderBox == null) {
      return false;
    }

    // Get the screen size
    final Size screenSize = MediaQuery.sizeOf(key.currentContext!);
    final Offset widgetTopLeft = widgetRenderBox.localToGlobal(Offset.zero);

    final Offset widgetBottomRight = Offset(
      widgetRenderBox.size.width,
      widgetRenderBox.size.height + widgetTopLeft.dy,
    );

    // Check the position and size of the widget against the screen size
    bool isEntirelyOnScreen =
        (widgetBottomRight.dy + widgetRenderBox.size.height) <=
        screenSize.height;

    if (!isEntirelyOnScreen) {
      final Size sizeScreen = MediaQuery.sizeOf(context);
      dropHeight ??= widget.children.length > 20 ? 300.0 : widget.maxHeight;
      if (widget.maxHeight == null || !isEntirelyOnScreenValueNotifier.value) {
        if (widget.showMode == MiraiShowMode.bottom) {
          dropHeight =
              sizeScreen.height -
              widget.position.dy -
              widget.size.height -
              context.bottomAdding;
        } else {
          double appBarHeight = AppBar().preferredSize.height;
          dropHeight =
              widget.position.dy - context.topPadding - appBarHeight - 20;
        }

        double dropPosition = (dropHeight ?? 0) - widget.position.dy;
        dropPosition = dropPosition.abs();

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

    return isEntirelyOnScreen;
  }
}
