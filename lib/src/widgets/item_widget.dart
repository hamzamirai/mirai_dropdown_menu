/*
* Created By Mirai Devs.
* On 9/10/2023.
*/
import 'package:flutter/material.dart';
import 'package:mirai_dropdown_menu/src/utils/common_function.dart';
import 'package:mirai_dropdown_menu/src/widgets/search_text_field_widget.dart';

import 'item_to_return_widget.dart';
import 'other_widget.dart';

class ItemWidget<T> extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.index,
    required this.onTapChild,
    required this.showOtherAndItsTextField,
    required this.showSearchTextField,
    required this.searchListLength,
    required this.itemPadding,
    required this.child,
    required this.searchNoDataWidget,
    required this.itemOverlayColor,
    required this.itemBackgroundColor,
    required this.itemMargin,
    required this.selectedItemBackgroundColor,
    required this.itemHeight,

    /// Search Fields
    required this.searchController,
    required this.searchDecoration,
    required this.searchValidator,
    required this.onChanged,
    required this.searchTextFormFieldStyle,

    /// Other Fields
    required this.otherController,
    required this.otherDecoration,
    required this.otherValidator,
    required this.otherOnFieldSubmitted,
    required this.otherHeight,
    required this.otherMargin,
    required this.radius,
    required this.isFirst,
    required this.isLast,
    required this.scrollController,
    required this.onTapOtherTextField,
  });

  final Widget? child;
  final Widget? searchNoDataWidget;
  final int index;
  final VoidCallback? onTapChild;
  final EdgeInsetsGeometry? itemPadding;
  final bool showOtherAndItsTextField;
  final bool showSearchTextField;
  final int searchListLength;

  /// Search Fields
  final TextEditingController? searchController;
  final InputDecoration? searchDecoration;
  final FormFieldValidator<String>? searchValidator;
  final ValueChanged<String>? onChanged;
  final TextStyle? searchTextFormFieldStyle;

  /// Other Fields
  final TextEditingController? otherController;
  final InputDecoration? otherDecoration;
  final FormFieldValidator<String>? otherValidator;
  final ValueChanged<String>? otherOnFieldSubmitted;
  final double? otherHeight;
  final EdgeInsetsGeometry? otherMargin;

  final Color? itemOverlayColor;
  final Color? itemBackgroundColor;
  final EdgeInsetsGeometry? itemMargin;
  final Color? selectedItemBackgroundColor;
  final double? itemHeight;

  final double radius;
  final bool isFirst;
  final bool isLast;

  final ScrollController? scrollController;

  final GestureTapCallback? onTapOtherTextField;

  @override
  Widget build(BuildContext context) {
    miraiPrint('showSearchTextField $showSearchTextField');
    miraiPrint('showOtherAndItsTextField $showOtherAndItsTextField');
    miraiPrint('searchListLength $searchListLength');
    miraiPrint('index $index');
    miraiPrint('CheckOther ${index != searchListLength + (showSearchTextField ? 1 : 0)}');
    if (!showOtherAndItsTextField) {
      if (showSearchTextField) {
        if (index == 0 && showSearchTextField) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SearchTextFieldWidget(
                searchController: searchController,
                searchDecoration: searchDecoration,
                searchValidator: searchValidator,
                onChanged: onChanged,
                searchTextFormFieldStyle: searchTextFormFieldStyle,
                scrollController: scrollController,
              ),
              if (searchListLength <= 1)
                searchNoDataWidget ??
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: Text('No Data!'),
                      ),
                    ),
            ],
          );
        } else {
          return ItemToReturnWidget<T>(
            index: index - 1,
            onTapChild: onTapChild,
            padding: itemPadding,
            itemOverlayColor: itemOverlayColor,
            itemBackgroundColor: itemBackgroundColor,
            itemHeight: itemHeight,
            radius: radius,
            isFirst: isFirst,
            isLast: isLast,
            selectedItemBackgroundColor: selectedItemBackgroundColor,
            margin: itemMargin,
            child: child,
          );
        }
      } else {
        return ItemToReturnWidget<T>(
          index: index,
          onTapChild: onTapChild,
          padding: itemPadding,
          itemOverlayColor: itemOverlayColor,
          itemBackgroundColor: itemBackgroundColor,
          itemHeight: itemHeight,
          radius: radius,
          isFirst: isFirst,
          isLast: isLast,
          selectedItemBackgroundColor: selectedItemBackgroundColor,
          margin: itemMargin,
          child: child,
        );
      }
    } else {
      if (index != (searchListLength - 1)) {
        if (showSearchTextField) {
          if (index == 0) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SearchTextFieldWidget(
                  searchController: searchController,
                  searchDecoration: searchDecoration,
                  searchValidator: searchValidator,
                  onChanged: onChanged,
                  searchTextFormFieldStyle: searchTextFormFieldStyle,
                  scrollController: scrollController,
                ),
                if (searchListLength <= 2)
                  searchNoDataWidget ??
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Text('No Data!'),
                        ),
                      ),
              ],
            );
          } else {
            return ItemToReturnWidget<T>(
              index: index - 1,
              onTapChild: onTapChild,
              padding: itemPadding,
              itemOverlayColor: itemOverlayColor,
              itemBackgroundColor: itemBackgroundColor,
              selectedItemBackgroundColor: selectedItemBackgroundColor,
              itemHeight: itemHeight,
              radius: radius,
              isFirst: isFirst,
              isLast: isLast,
              margin: itemMargin,
              child: child,
            );
          }
        } else {
          return ItemToReturnWidget<T>(
            index: index,
            onTapChild: onTapChild,
            padding: itemPadding,
            itemOverlayColor: itemOverlayColor,
            itemBackgroundColor: itemBackgroundColor,
            itemHeight: itemHeight,
            radius: radius,
            isFirst: isFirst,
            isLast: isLast,
            selectedItemBackgroundColor: selectedItemBackgroundColor,
            margin: itemMargin,
            child: child,
          );
        }
      } else {
        return OtherWidget(
          otherController: otherController,
          otherDecoration: otherDecoration,
          otherValidator: otherValidator,
          onFieldSubmitted: otherOnFieldSubmitted,
          height: otherHeight,
          margin: otherMargin,
          scrollController: scrollController,
          onTapOtherTextField: onTapOtherTextField,
        );
      }
    }
  }
}
