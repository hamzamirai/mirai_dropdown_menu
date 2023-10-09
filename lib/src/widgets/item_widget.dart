/*
* Created By Mirai Devs.
* On 9/10/2023.
*/
import 'package:flutter/material.dart';
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
    required this.itemOverlayColor,
    required this.itemHeight,

    /// Search Fields
    required this.searchController,
    required this.searchDecoration,
    required this.searchValidator,
    required this.onChanged,
    required this.radius,
    required this.isFirst,
    required this.isLast,
  });

  final Widget? child;
  final int index;
  final VoidCallback onTapChild;
  final EdgeInsetsGeometry? itemPadding;
  final bool showOtherAndItsTextField;
  final bool showSearchTextField;
  final int searchListLength;

  /// Search Fields
  final TextEditingController? searchController;
  final InputDecoration? searchDecoration;
  final FormFieldValidator<String>? searchValidator;
  final ValueChanged<String>? onChanged;

  final Color? itemOverlayColor;
  final double? itemHeight;

  final double radius;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    if (!showOtherAndItsTextField) {
      if (showSearchTextField) {
        if (index == 0 && showSearchTextField) {
          return SearchTextFieldWidget(
            searchController: searchController,
            searchDecoration: searchDecoration,
            searchValidator: searchValidator,
            onChanged: onChanged,
          );
        } else {
          return ItemToReturnWidget<T>(
            index: index - 1,
            onTapChild: onTapChild,
            padding: itemPadding,
            itemOverlayColor: itemOverlayColor,
            itemHeight: itemHeight,
            radius: radius,
            isFirst: isFirst,
            isLast: isLast,
            child: child,
          );
        }
      } else {
        //  return buildItemToReturn(index, children);
        return ItemToReturnWidget<T>(
          index: index,
          onTapChild: onTapChild,
          padding: itemPadding,
          itemOverlayColor: itemOverlayColor,
          itemHeight: itemHeight,
          radius: radius,
          isFirst: isFirst,
          isLast: isLast,
          child: child,
        );
      }
    } else {
      if (index != searchListLength + (showSearchTextField ? 1 : 0)) {
        if (showSearchTextField) {
          if (index == 0) {
            return SearchTextFieldWidget(
              searchController: searchController,
              searchDecoration: searchDecoration,
              searchValidator: searchValidator,
              onChanged: onChanged,
            );
          } else {
            return ItemToReturnWidget<T>(
              index: index - 1,
              onTapChild: onTapChild,
              padding: itemPadding,
              itemOverlayColor: itemOverlayColor,
              itemHeight: itemHeight,
              radius: radius,
              isFirst: isFirst,
              isLast: isLast,
              child: child,
            );
          }
        } else {
          return ItemToReturnWidget<T>(
            index: index,
            onTapChild: onTapChild,
            padding: itemPadding,
            itemOverlayColor: itemOverlayColor,
            itemHeight: itemHeight,
            radius: radius,
            isFirst: isFirst,
            isLast: isLast,
            child: child,
          );
        }
      } else {
        return const OtherWidget();
      }
    }
  }
}
