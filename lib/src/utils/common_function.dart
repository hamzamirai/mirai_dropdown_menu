/*
* Created By Mirai Devs.
* On 5/11/2023.
*/

import 'package:flutter/foundation.dart';

void miraiPrint(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}

T? safeGet<T>(List<T> list, int index) {
  if (index >= 0 && index < list.length) {
    return list[index];
  }
  return null;
}