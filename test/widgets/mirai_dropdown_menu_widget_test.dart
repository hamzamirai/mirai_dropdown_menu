import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

void main() {
  group('MiraiDropDownMenu Comprehensive Widget Tests', () {
    testWidgets('does not open when enable is false', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                enable: false,
                key: const Key('dropdown_disabled'),
                children: const <String>['Item 1', 'Item 2'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Disabled Dropdown'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Disabled Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('Item 1'), findsNothing);
      expect(find.text('Item 2'), findsNothing);
    });

    testWidgets('shows snackbar when children list is empty', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown_empty'),
                emptyListMessage: 'Custom Empty Message',
                children: const <String>[],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Empty Dropdown'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Empty Dropdown'));
      await tester.pump();

      expect(find.text('Custom Empty Message'), findsOneWidget);
    });

    testWidgets('handles multi-selection mode with selected items notifier', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      final ValueNotifier<List<String>> selectedNotifier =
          ValueNotifier<List<String>>(<String>[]);
      List<String> lastMultiChanged = <String>[];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown_multi'),
                isMultiSelection: true,
                selectedItemsNotifier: selectedNotifier,
                onMultiChanged: (List<String> items) {
                  lastMultiChanged = items;
                },
                children: const <String>['Option 1', 'Option 2', 'Option 3'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Row(
                        children: <Widget>[
                          Text(item ?? ''),
                          if (isItemSelected) const Icon(Icons.check),
                        ],
                      );
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Multi Select Dropdown'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Multi Select Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);

      await tester.tap(find.text('Option 1'));
      await tester.pumpAndSettle();

      expect(lastMultiChanged, contains('Option 1'));
    });

    testWidgets('renders itemHighLightBuilder when searching query', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown_highlight'),
                showSearchTextField: true,
                children: const <String>['Flutter Framework', 'Dart Language'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                itemHighLightBuilder: (
                  int index,
                  String? item,
                  String query, {
                  bool isItemSelected = false,
                }) {
                  return Text('MATCH: $item with $query');
                },
                child: Container(
                  key: childKey,
                  child: const Text('Highlight Dropdown'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Highlight Dropdown'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextFormField), 'Flutter');
      await tester.pumpAndSettle();

      expect(
        find.text('MATCH: Flutter Framework with Flutter'),
        findsOneWidget,
      );
    });

    testWidgets('allows custom styling properties', (
      WidgetTester tester,
    ) async {
      final GlobalKey childKey = GlobalKey();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MiraiDropDownMenu<String>(
                key: const Key('dropdown_styled'),
                itemHeight: 50,
                itemMargin: const EdgeInsets.all(8),
                itemPadding: const EdgeInsets.symmetric(horizontal: 16),
                separatorColor: Colors.red,
                showSeparator: true,
                itemBackgroundColor: Colors.grey.shade200,
                selectedItemBackgroundColor: Colors.blue.shade100,
                children: const <String>['Styled 1', 'Styled 2'],
                itemWidgetBuilder:
                    (int index, String? item, {bool isItemSelected = false}) {
                      return Text(item ?? '');
                    },
                child: Container(
                  key: childKey,
                  child: const Text('Styled Dropdown'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Styled Dropdown'));
      await tester.pumpAndSettle();

      expect(find.text('Styled 1'), findsOneWidget);
      expect(find.text('Styled 2'), findsOneWidget);
    });
  });
}
