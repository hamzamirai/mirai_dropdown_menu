import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

void main() {
  group('MiraiDropDownMenu Widget Tests', () {
    testWidgets('renders child widget correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown'),
                children: const <String>['Item 1', 'Item 2'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: GlobalKey(),
                  child: const Text('Select Option'),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Select Option'), findsOneWidget);
    });

    testWidgets('opens dropdown and shows items when tapped', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown'),
                children: const <String>['Item 1', 'Item 2', 'Item 3'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Select Option'),
                ),
              ),
            ),
          ),
        ),
      );

      // Verify dropdown content is not yet visible
      expect(find.text('Item 1'), findsNothing);

      // Tap to open
      await tester.tap(find.text('Select Option'));
      await tester.pumpAndSettle();

      // Items should now be visible
      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
      expect(find.text('Item 3'), findsOneWidget);
    });

    testWidgets('displays search field when showSearchTextField is true', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown'),
                showSearchTextField: true,
                children: const <String>['Apple', 'Banana', 'Cherry'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Select Option'),
                ),
              ),
            ),
          ),
        ),
      );

      // Tap to open
      await tester.tap(find.text('Select Option'));
      await tester.pumpAndSettle();

      // Check search field exists (it sets up a TextFormField)
      expect(find.byType(TextFormField), findsOneWidget);

      // Perform a search
      await tester.enterText(find.byType(TextFormField), 'Apple');
      await tester.pumpAndSettle();

      // Apple should be visible in search field and filtered item list, Banana should not
      expect(find.text('Apple'), findsNWidgets(2));
      expect(find.text('Banana'), findsNothing);
    });

    testWidgets('calls onChanged when an item is tapped', (
      WidgetTester tester,
    ) async {
      String? selectedValue;
      final GlobalKey childKey = GlobalKey();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown'),
                children: const <String>['Item 1', 'Item 2', 'Item 3'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                onChanged: (String value) {
                  selectedValue = value;
                },
                child: Container(
                  key: childKey,
                  child: const Text('Select Option'),
                ),
              ),
            ),
          ),
        ),
      );

      // Tap to open
      await tester.tap(find.text('Select Option'));
      await tester.pumpAndSettle();

      // Tap an item
      await tester.tap(find.text('Item 2'));
      await tester.pumpAndSettle();

      // Ensure callback was called correctly
      expect(selectedValue, 'Item 2');
    });

    testWidgets('displays other field when showOtherAndItsTextField is true', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown'),
                showOtherAndItsTextField: true,
                children: const <String>['Item 1', 'Item 2'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Select Option'),
                ),
              ),
            ),
          ),
        ),
      );

      // Tap to open
      await tester.tap(find.text('Select Option'));
      await tester.pumpAndSettle();

      // "Other:" string is used as a hint in the other widget
      expect(find.text('Other:'), findsOneWidget);
    });
  });
}
