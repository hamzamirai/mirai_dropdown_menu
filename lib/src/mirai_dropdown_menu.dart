/*
* Created By Mirai Devs.
* On 3/28/2022.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/models/search_attributes_model.dart';
import 'package:mirai_dropdown_menu/src/utils/mirai_outline_input_border.dart';

import 'widgets/mirai_keyboard_visibility_builder_widget.dart';

part 'utils/enums.dart';

typedef MiraiDropdownBuilder<T> = Widget Function(int index, T item);
typedef MiraiValueChanged<T> = void Function(T value);

class MiraiPopupMenu<T> extends StatefulWidget {
  MiraiPopupMenu({
    Key? key,
    required this.child,
    this.other,
    required this.itemWidget,
    required this.children,
    this.mode = MiraiPopupMenuMode.dropDownMenu,
    this.showMode = MiraiShowMode.bottom,
    this.onChanged,
    this.maxHeight,
    this.enable = true,
    this.showSeparator = true,
    this.showOtherAndItsTextField = false,
    this.onOtherChanged,
    this.exit = MiraiExit.fromAll,
    this.isExpanded,
    this.space = 3,
    this.emptyListMessage,
    this.showSearchTextField = false,
    this.searchDecoration,
    this.searchQuery,
  })  : assert(child.key != null),
        super(key: key);

  /// Child widget that has dropdown menu
  final Widget child;
  final Widget? other;

  /// itemWidget, is a widget that we display as an item in the list menu
  final MiraiDropdownBuilder<T> itemWidget;

  /// children, is the list that we display in the dropdown
  final List<T> children;

  /// The max height of the dropdown
  final double? maxHeight;

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
  final String? searchQuery;

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
    RenderBox renderBox = (widget.child.key as GlobalKey)
        .currentContext
        ?.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    if (widget.children.isNotEmpty) {
      showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return _DropDownMenuContent<T>(
            maxHeight: widget.maxHeight,
            space: widget.space,
            showMode: widget.showMode,
            itemWidget: widget.itemWidget,
            mode: widget.mode,
            position: position,
            size: renderBox.size,
            onChanged: widget.onChanged,
            children: widget.children,
            exit: widget.exit,
            isExpanded: widget.isExpanded,
            showOtherAndItsTextField: widget.showOtherAndItsTextField,
            showSeparator: widget.showSeparator,
            onOtherChanged: widget.onOtherChanged,
            showSearchTextField: widget.showSearchTextField,
            searchDecoration: widget.searchDecoration,
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
    required this.itemWidget,
    required this.position,
    required this.size,
    required this.mode,
    required this.showMode,
    this.onChanged,
    this.maxHeight,
    required this.showOtherAndItsTextField,
    required this.showSeparator,
    this.onOtherChanged,
    this.exit = MiraiExit.fromAll,
    this.isExpanded,
    required this.space,
    this.other,
    this.showSearchTextField = false,
    this.searchDecoration,
    this.searchQuery,
  }) : super(key: key);

  final List<T> children;
  final MiraiDropdownBuilder<T> itemWidget;
  final Offset position;
  final Size size;
  final ValueChanged<T>? onChanged;
  final MiraiPopupMenuMode mode;
  final MiraiShowMode showMode;
  final double? maxHeight;
  final bool showOtherAndItsTextField;
  final bool showSeparator;
  final ValueChanged<String>? onOtherChanged;
  final MiraiExit exit;
  final ValueChanged<bool>? isExpanded;
  final double space;
  final Widget? other;

  final bool showSearchTextField;
  final InputDecoration? searchDecoration;
  final String? searchQuery;

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
  ValueNotifier<SearchAttributes<T>> searchChildren =
      ValueNotifier<SearchAttributes<T>>(
    SearchAttributes<T>(),
  );

  ///  Search Controller
  final TextEditingController searchController = TextEditingController();

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
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size sizeScreen = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _closePopup(context: context, action: null);
        return false;
      },
      child: GestureDetector(
        onTap: () => (widget.exit == MiraiExit.fromAll ||
                widget.exit == MiraiExit.outside)
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
                  right: (sizeScreen.width - widget.position.dx) -
                      widget.size.width,
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
                      height:
                          widget.children.length > 20 ? 300 : widget.maxHeight,
                      width: widget.size.width - 1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
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
                      child: ValueListenableBuilder<SearchAttributes<T>>(
                        valueListenable: searchChildren,
                        builder: (_, SearchAttributes<T> children, __) {
                          return Scrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            radius: const Radius.circular(20),
                            child: ListView.separated(
                              controller: _scrollController,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: children.searchList.length +
                                  (widget.showOtherAndItsTextField ? 1 : 0) +
                                  (widget.showSearchTextField ? 1 : 0),
                              itemBuilder: (_, int index) {
                                return itemBuilderReturn(children, index);
                              },
                              separatorBuilder: (_, int index) {
                                if (widget.showSeparator) {
                                  return buildSeparator();
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
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

  Widget itemBuilderReturn(SearchAttributes<T> children, int index) {
    if (!widget.showOtherAndItsTextField) {
      if (widget.showSearchTextField) {
        if (index == 0 && widget.showSearchTextField) {
          return buildSearchTextField(context);
        } else {
          return buildItemToReturn(
            index - 1,
            children,
          );
        }
      } else {
        return buildItemToReturn(index, children);
      }
    } else {
      if (index !=
          children.searchList.length + (widget.showSearchTextField ? 1 : 0)) {
        if (widget.showSearchTextField) {
          if (index == 0) {
            return buildSearchTextField(context);
          } else {
            return buildItemToReturn(
              index - 1,
              children,
            );
          }
        } else {
          return buildItemToReturn(index, children);
        }
      } else {
        debugPrint('buildOtherWidget index$index');
        return buildOtherWidget();
      }
    }
  }

  InkWell buildItemToReturn(int index, SearchAttributes<T> children) {
    debugPrint('children index: $index');
    return InkWell(
      onTap: () => onTapChild(index),
      child: widget.itemWidget(
        index,
        children.searchList[index],
      ),
    );
  }

  Container buildSearchTextField(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      child: TextFormField(
        controller: searchController,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).primaryColorDark,
            ),
        cursorColor: Theme.of(context).primaryColorDark,
        decoration: widget.searchDecoration ??
            InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(12),
              hintText: 'Search...',
              border: miraiOutlineInputBorderForTextField(),
            ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {},
        onChanged: (String text) {
          searchSubscription(text);
        },
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
        return Container(
          color: Colors.red,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: isKeyboardVisible ? 46 : 0,
            ),
            child: widget.other,
          ),
        );
      },
    );
  }

  Container buildSeparator() {
    return Container(
      height: 1,
      color: const Color(0xFF707070).withOpacity(0.2),
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
    if (query.isNotEmpty) {
      searchChildren.value.showHighLight = true;
      searchChildren.value.mQueryClient = query;

      final results = widget.children.where((child) =>
          '${(child is String) ? child : widget.searchQuery}'
              .toLowerCase()
              .contains(query));
      searchChildren.value.searchList = List.from(results);
    } else {
      searchChildren.value.showHighLight = false;
      searchChildren.value.mQueryClient = '';
      searchChildren.value.searchList = List.from(widget.children);
    }
    searchChildren.notifyListeners();
  }
}
