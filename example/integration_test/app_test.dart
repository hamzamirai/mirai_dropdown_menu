import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Mirai Dropdown Menu Example App Integration Tests', () {
    testWidgets('Complete user journey from Home to String and Object dropdowns', (
      WidgetTester tester,
    ) async {
      // 1. Launch application
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // 2. Verify Home Screen title and action buttons
      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Mirai Dropdown Menu'), findsOneWidget);
      expect(find.text('List of Texts/Strings'), findsOneWidget);
      expect(find.text('List of Objects'), findsOneWidget);

      // 3. Navigate to List of Texts/Strings screen
      await tester.ensureVisible(find.text('List of Texts/Strings'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('List of Texts/Strings'));
      await tester.pumpAndSettle();

      expect(find.text('String Dropdowns'), findsOneWidget);
      expect(find.text('Open Dropdown'), findsOneWidget);

      // 4. Open dropdown via action button
      await tester.tap(find.text('Open Dropdown'));
      await tester.pumpAndSettle();

      // Verify items are displayed
      expect(find.text('Flutter 1'), findsWidgets);
      expect(find.text('Dart 2'), findsWidgets);

      // Tap on an item
      await tester.tap(find.text('Dart 2').first);
      await tester.pumpAndSettle();

      // 5. Navigate back to Home
      final Finder backButton = find.byType(BackButton);
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      } else {
        await tester.pageBack();
        await tester.pumpAndSettle();
      }

      expect(find.text('List of Objects'), findsOneWidget);

      // 6. Navigate to List of Objects screen
      await tester.ensureVisible(find.text('List of Objects'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('List of Objects'));
      await tester.pumpAndSettle();

      expect(find.text('Object Dropdowns'), findsOneWidget);

      // 7. Navigate back to Home
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      } else {
        await tester.pageBack();
        await tester.pumpAndSettle();
      }

      expect(find.text('Welcome to'), findsOneWidget);
    });
  });
}
