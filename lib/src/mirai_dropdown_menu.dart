/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/models/search_attributes_model.dart';
import 'package:mirai_dropdown_menu/src/widgets/item_widget.dart';
import 'package:mirai_dropdown_menu/src/widgets/separator_widget.dart';

import 'utils/common_function.dart';
import 'widgets/mirai_keyboard_visibility_builder_widget.dart';

part 'utils/enums.dart';

typedef MiraiDropdownBuilder<T> = Widget Function(int index, T? item);

typedef MiraiHighLightDropdownBuilder<T> = Widget Function(
    int index, SearchAttributes<T> item);

typedef MiraiValueChanged<T> = void Function(T value);

class MiraiPopupMenu<T> extends StatefulWidget {
  MiraiPopupMenu({
    Key? key,
    required this.child,
    this.other,
    this.decoration,
    required this.itemWidgetBuilder,
    this.itemHighLightBuilder,
    required this.children,
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
    this.itemPadding,
    this.itemOverlayColor,
    this.itemHeight,
    this.separatorColor,

    /// Other
    this.otherController,
    this.otherDecoration,
    this.otherValidator,
    this.otherOnFieldSubmitted,
    this.otherHeight,
    this.otherMargin,
  })  : assert(child.key != null),
        super(key: key);

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

  final EdgeInsetsGeometry? itemPadding;

  final Color? itemOverlayColor;
  final double? itemHeight;

  final Color? separatorColor;
  final bool listThumbVisibility;

  /// Other
  final TextEditingController? otherController;
  final InputDecoration? otherDecoration;
  final FormFieldValidator<String>? otherValidator;
  final ValueChanged<String>? otherOnFieldSubmitted;
  final double? otherHeight;
  final EdgeInsetsGeometry? otherMargin;

  @override
  MiraiPopupMenuState<T> createState() => MiraiPopupMenuState<T>();
}

class MiraiPopupMenuState<T> extends State<MiraiPopupMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enable ? _showDropDownMenu : null,
      child: widget.child,
    );
  }

  void _showDropDownMenu() {
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
            decoration: widget.decoration,
            exit: widget.exit,
            isExpanded: widget.isExpanded,
            showOtherAndItsTextField: widget.showOtherAndItsTextField,
            showSeparator: widget.showSeparator,
            onOtherChanged: widget.onOtherChanged,
            showSearchTextField: widget.showSearchTextField,
            searchDecoration: widget.searchDecoration,
            searchValidator: widget.searchValidator,
            itemPadding: widget.itemPadding,
            itemOverlayColor: widget.itemOverlayColor,
            itemHeight: widget.itemHeight,
            separatorColor: widget.separatorColor,
            listThumbVisibility: widget.listThumbVisibility,

            /// Other
            otherController: widget.otherController,
            otherDecoration: widget.otherDecoration,
            otherValidator: widget.otherValidator,
            otherOnFieldSubmitted: widget.otherOnFieldSubmitted,
            otherHeight: widget.otherHeight,
            otherMargin: widget.otherMargin,
            other: widget.other,
            itemHighLightBuilder: widget.itemHighLightBuilder,
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
    Key? key,
    required this.children,
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
    required this.itemHeight,
    required this.separatorColor,
    required this.listThumbVisibility,
  }) : super(key: key);

  final List<T> children;
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

  final TextEditingController? otherController;
  final InputDecoration? otherDecoration;
  final FormFieldValidator<String>? otherValidator;
  final ValueChanged<String>? otherOnFieldSubmitted;
  final double? otherHeight;
  final EdgeInsetsGeometry? otherMargin;

  final EdgeInsetsGeometry? itemPadding;

  final Color? itemOverlayColor;
  final double? itemHeight;

  final Color? separatorColor;

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

  ///  Search Controller
  final TextEditingController searchController = TextEditingController();

  GlobalKey myWidgetKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    /// Copy children to searchChildren.value.searchList
    searchChildren.value.searchList = List.from(widget.children);

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
    final Size sizeScreen = MediaQuery.sizeOf(context);
    dropHeight ??= widget.children.length > 20.0 ? 300.0 : widget.maxHeight;
    // miraiPrint('dropHeight $dropHeight');

    return WillPopScope(
      onWillPop: () async {
        _closePopup(context: context, action: null);
        return false;
      },
      child: GestureDetector(
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
              children: [
                Positioned(
                  right: (sizeScreen.width - widget.position.dx) - widget.size.width,
                  top: widget.showMode != MiraiShowMode.top
                      ? widget.position.dy + widget.space + widget.size.height
                      : null,
                  bottom: widget.showMode != MiraiShowMode.bottom
                      ? sizeScreen.height - widget.position.dy + widget.space
                      : null,
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        alignment: widget.showMode != MiraiShowMode.top
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        child: Opacity(
                          opacity: _animation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      height: dropHeight,
                      width: widget.size.width, // - 1,
                      decoration: widget.decoration ??
                          BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(widget.radius ?? 5),
                            border: Border.all(
                              color: const Color(0xFFCECECE),
                              width: 0.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                      child: LayoutBuilder(
                        key: myWidgetKey,
                        builder: (_, BoxConstraints constraints) {
                          // miraiPrint('constraints maxHeight  ${constraints.maxHeight}');
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
                                  padding: EdgeInsets.zero,
                                  itemCount: itemCount,
                                  itemBuilder: (_, int index) {
                                    final int newIndex =
                                        widget.showSearchTextField ? index - 1 : index;

                                    final searchList =
                                        safeGet(children.searchList, newIndex);
                                    return ItemWidget(
                                      index: index,
                                      onTapChild: () => onTapChild(index),
                                      showOtherAndItsTextField:
                                          widget.showOtherAndItsTextField,
                                      showSearchTextField: widget.showSearchTextField,
                                      searchListLength: children.searchList.length,

                                      /// Search
                                      searchController: searchController,
                                      searchDecoration: widget.searchDecoration,
                                      searchValidator: widget.searchValidator,
                                      onChanged: searchSubscription,

                                      /// Other
                                      otherController: widget.otherController,
                                      otherDecoration: widget.searchDecoration,
                                      otherValidator: widget.searchValidator,
                                      otherOnFieldSubmitted: widget.otherOnFieldSubmitted,
                                      otherHeight: widget.otherHeight,
                                      otherMargin: widget.otherMargin,

                                      ///
                                      itemPadding: widget.itemPadding,
                                      itemOverlayColor: widget.itemOverlayColor,
                                      itemHeight: widget.itemHeight,
                                      radius: widget.radius ?? 5,
                                      isFirst: index == 0,
                                      isLast: index == children.searchList.length - 1,
                                      child: widget.itemWidgetBuilder(
                                        index,
                                        searchList,
                                      ),
                                    );
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  MiraiKeyboardVisibilityBuilder buildOtherWidget() {
    return MiraiKeyboardVisibilityBuilder(
      builder: (context, child, isKeyboardVisible) {
        if (isKeyboardVisible) {
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );
        }
        return Padding(
          padding: EdgeInsets.only(
            bottom: isKeyboardVisible ? 46 : 0,
          ),
          child: widget.other,
        );
      },
    );
  }

  void _closePopup({required BuildContext context, required T? action}) {
    widget.isExpanded?.call(false);
    _animationController.reverse().whenComplete(() {
      if (action != null) widget.onChanged?.call(action);
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
    searchChildren.value.searchList = List.from(widget.children);
  }

  void searchSubscription(String query) {
    SearchAttributes<T> searchAttributes = SearchAttributes<T>();
    if (query.isNotEmpty) {
      searchAttributes.showHighLight = true;
      searchAttributes.mQueryClient = query;

      final results = widget.children.where((child) =>
          ((child is String) ? child : child.toString()).toLowerCase().contains(query));
      searchAttributes.searchList = List.from(results);
    } else {
      searchAttributes.showHighLight = false;
      searchAttributes.mQueryClient = '';
      searchAttributes.searchList = List.from(widget.children);
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

    final Offset widgetTopLeft = widgetRenderBox.localToGlobal(Offset.zero);
    final Offset widgetBottomRight = Offset(
        widgetRenderBox.size.width,
        widgetRenderBox.size.height +
            widgetTopLeft.dy +
            widget.space +
            widget.size.height);

    // Get the screen size
    final Size screenSize = MediaQuery.sizeOf(key.currentContext!);
    // final EdgeInsets padding = MediaQuery.paddingOf(key.currentContext!);

    // Check the position and size of the widget against the screen size
    bool isEntirelyOnScreen = widgetTopLeft.dx >= 0 &&
        widgetTopLeft.dy >= 0 &&
        widgetBottomRight.dx <= screenSize.width &&
        widgetBottomRight.dy <= screenSize.height;

    //   print('isEntirelyOnScreen $isEntirelyOnScreen');
    //   print('widgetTopLeft dx ${widgetTopLeft.dx}');
    //   print('widgetTopLeft dy ${widgetTopLeft.dy}');
    //   print('widgetBottomRight dx ${widgetBottomRight.dx}');
    //   print('widgetBottomRight dy ${widgetBottomRight.dy}');
    //   print('screenSize width ${screenSize.width}');
    //   print('screenSize height ${screenSize.height}');
    //

    // miraiPrint('widgetTopLeft: $widgetTopLeft');
    // miraiPrint('widgetBottomRight: $widgetBottomRight');
    // miraiPrint('screenSize: $screenSize');
    // miraiPrint('padding: $padding');
    // miraiPrint('Rest: ${widgetBottomRight.dy - screenSize.height}');
    final rest = widgetBottomRight.dy - screenSize.height;

    if (!isEntirelyOnScreen) {
      setState(() {
        dropHeight =
            widgetRenderBox.size.height - rest - widget.size.height - widget.space;
        // miraiPrint('dropHeight: $dropHeight');
      });
    }

    return isEntirelyOnScreen;
  }
}
