import 'package:flutter_test/flutter_test.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

void main() {
  group('Enums Unit Tests', () {
    test('MiraiPopupMenuMode contains expected enum values', () {
      expect(
        MiraiPopupMenuMode.values,
        containsAll(<MiraiPopupMenuMode>[
          MiraiPopupMenuMode.popupMenu,
          MiraiPopupMenuMode.dropDownMenu,
        ]),
      );
    });

    test('MiraiShowMode contains expected enum values', () {
      expect(
        MiraiShowMode.values,
        containsAll(<MiraiShowMode>[
          MiraiShowMode.top,
          MiraiShowMode.bottom,
        ]),
      );
    });

    test('MiraiExit contains expected enum values', () {
      expect(
        MiraiExit.values,
        containsAll(<MiraiExit>[
          MiraiExit.fromAll,
          MiraiExit.outside,
          MiraiExit.inside,
        ]),
      );
    });
  });
}
