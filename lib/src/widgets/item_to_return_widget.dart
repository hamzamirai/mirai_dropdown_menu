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
    required this.padding,
    required this.itemOverlayColor,
    required this.itemHeight,
    required this.radius,
    required this.isFirst,
    required this.isLast,
  });

  final Widget? child;
  final int index;
  final VoidCallback onTapChild;
  final EdgeInsetsGeometry? padding;
  final Color? itemOverlayColor;
  final double? itemHeight;

  final double radius;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: itemHeight,
      child: ElevatedButton(
        onPressed: onTapChild,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isFirst ? radius : 0),
              topRight: Radius.circular(isFirst ? radius : 0),
              bottomLeft: Radius.circular(isLast ? radius : 0),
              bottomRight: Radius.circular(isLast ? radius : 0),
            ),
          ),
        ).copyWith(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(padding),
          overlayColor: MaterialStateProperty.all(itemOverlayColor),
        ),
        child: child,
      ),
    );
  }
}

// onTapChild(index)
