/*
* Created By Mirai Devs.
* On 9/10/2023.
*/
import 'package:flutter/material.dart';

class ItemToReturnWidget<T> extends StatelessWidget {
  const ItemToReturnWidget({
    super.key,
    required this.index,
    required this.onTapChild,
    required this.child,
    required this.margin,
    required this.padding,
    required this.itemOverlayColor,
    required this.itemBackgroundColor,
    required this.selectedItemBackgroundColor,
    required this.itemHeight,
    required this.radius,
    required this.isFirst,
    required this.isLast,
  });

  final Widget? child;
  final int index;
  final VoidCallback? onTapChild;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? itemOverlayColor;
  final Color? itemBackgroundColor;
  final Color? selectedItemBackgroundColor;
  final double? itemHeight;

  final double radius;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry? borderRadius = (selectedItemBackgroundColor != null)
        ? BorderRadius.circular(radius)
        : BorderRadius.only(
            topLeft: Radius.circular(isFirst ? radius : 0),
            topRight: Radius.circular(isFirst ? radius : 0),
            bottomLeft: Radius.circular(isLast ? radius : 0),
            bottomRight: Radius.circular(isLast ? radius : 0),
          );
    return Container(
      margin: margin,
      height: itemHeight,
      decoration: BoxDecoration(
        color: selectedItemBackgroundColor ?? itemBackgroundColor,
        borderRadius: borderRadius,
      ),
      child: ElevatedButton(
        onPressed: onTapChild,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              selectedItemBackgroundColor ?? itemBackgroundColor ?? Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          // minimumSize:
          //     itemHeight != null ? Size(double.infinity, itemHeight!) : null
        ).copyWith(
          elevation: MaterialStateProperty.all(0),
          //padding: MaterialStateProperty.all(padding),
          overlayColor: MaterialStateProperty.all(itemOverlayColor),
        ),
        child: child,
      ),
    );
  }
}
