import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mirai_dropdown_menu/src/utils/common_function.dart';
import 'package:mirai_dropdown_menu/src/utils/extensions.dart';
import 'package:mirai_dropdown_menu/src/utils/mirai_outline_input_border.dart';

void main() {
  group('Utils & Extensions Unit Tests', () {
    group('safeGet function', () {
      final List<String> sampleList = <String>['first', 'second', 'third'];

      test('returns element at valid positive index', () {
        expect(safeGet(sampleList, 0), 'first');
        expect(safeGet(sampleList, 1), 'second');
        expect(safeGet(sampleList, 2), 'third');
      });

      test('returns null for negative index', () {
        expect(safeGet(sampleList, -1), isNull);
        expect(safeGet(sampleList, -10), isNull);
      });

      test('returns null for out of bounds index', () {
        expect(safeGet(sampleList, 3), isNull);
        expect(safeGet(sampleList, 100), isNull);
      });

      test('returns null for empty list', () {
        final List<int> emptyList = <int>[];
        expect(safeGet(emptyList, 0), isNull);
        expect(safeGet(emptyList, -1), isNull);
      });
    });

    group('miraiOutlineInputBorderForTextField function', () {
      test('returns OutlineInputBorder with default parameters', () {
        final OutlineInputBorder border = miraiOutlineInputBorderForTextField();

        expect(border.borderRadius, BorderRadius.circular(5));
        expect(border.borderSide.color, Colors.white);
        expect(border.borderSide.width, 1);
      });

      test('returns OutlineInputBorder with custom parameters', () {
        final OutlineInputBorder border = miraiOutlineInputBorderForTextField(
          color: Colors.blue,
          borderRadius: 12,
          borderWidth: 2.5,
        );

        expect(border.borderRadius, BorderRadius.circular(12));
        expect(border.borderSide.color, Colors.blue);
        expect(border.borderSide.width, 2.5);
      });
    });

    group('IntFutureExtension', () {
      test('waitForMilliseconds completes after delay', () async {
        final Stopwatch stopwatch = Stopwatch()..start();
        await 50.waitForMilliseconds();
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(40));
      });

      test('waitForSeconds completes after delay', () async {
        final Stopwatch stopwatch = Stopwatch()..start();
        await 1.waitForSeconds();
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(900));
      });
    });
  });
}
