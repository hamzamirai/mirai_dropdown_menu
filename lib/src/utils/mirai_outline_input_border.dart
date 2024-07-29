/*
* Created By Mirai Devs.
* On 24/6/2022.
*/
import 'package:flutter/material.dart';

OutlineInputBorder miraiOutlineInputBorderForTextField({
  Color color = Colors.white,
  double borderRadius = 5,
  double borderWidth = 1,
}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(borderRadius),
    borderSide: BorderSide(
      width: borderWidth,
      color: color,
    ),
  );
}
