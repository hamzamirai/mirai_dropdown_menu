/*
* Created By Mirai Devs.
* On 25/11/2023.
*/

import 'package:flutter/material.dart';

extension BottomPadding on BuildContext {
  double get topPadding => MediaQuery.paddingOf(this).top;

  double get bottomAdding => MediaQuery.paddingOf(this).bottom;

  bool get isKeyboardOpen {
    double keyBoardHeight = MediaQuery.of(this).viewInsets.bottom;
    return !(keyBoardHeight == 0);
  }
}

extension IntFutureExtension on int {
  // A method to wait for a number of seconds.
  Future<void> waitForSeconds() async {
    await Future<void>.delayed(Duration(seconds: this));
  }

  Future<void> waitForMilliseconds() async {
    await Future<void>.delayed(Duration(milliseconds: this));
  }
}
