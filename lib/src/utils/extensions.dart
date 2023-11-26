/*
* Created By Mirai Devs.
* On 25/11/2023.
*/

import 'package:flutter/material.dart';

extension BottomPadding on BuildContext {
  double get topPadding => MediaQuery.paddingOf(this).top;

  double get bottomAdding => MediaQuery.paddingOf(this).bottom;
}
