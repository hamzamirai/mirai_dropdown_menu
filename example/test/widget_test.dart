import 'package:example/app/core/localization/state/language_notifier.dart';
import 'package:example/app/screens/home_screen/home_screen.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    LanguageNotifier.instance.changeLanguage(const Locale('en', 'US'));
  });

  group('Example App Widget Tests', () {
    testWidgets('MyApp builds and shows HomeScreen', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Mirai Dropdown Menu'), findsWidgets);
      expect(find.text('List of Texts/Strings'), findsOneWidget);
      expect(find.text('List of Objects'), findsOneWidget);
    });

    testWidgets('Navigates to string dropdown screen and displays items', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.text('List of Texts/Strings'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('List of Texts/Strings'));
      await tester.pumpAndSettle();

      expect(find.text('String Dropdowns'), findsOneWidget);
      expect(find.text('Open Dropdown'), findsOneWidget);
    });

    testWidgets('Switches language to Arabic (RTL) dynamically', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Switch language to Arabic
      LanguageNotifier.instance.changeLanguageByCode('ar');
      await tester.pumpAndSettle();

      expect(find.text('مرحباً بك في'), findsOneWidget);
      expect(find.text('قائمة ميراي المنسدلة'), findsWidgets);
      expect(find.text('قائمة النصوص / السلاسل'), findsOneWidget);
      expect(find.text('قائمة الكائنات المخصصة'), findsOneWidget);
    });

    testWidgets('Opens language picker bottom sheet', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Tap on the language picker button in AppBar
      await tester.tap(find.byIcon(Icons.keyboard_arrow_down_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Select Language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('العربية'), findsOneWidget);
      expect(find.text('Français'), findsOneWidget);
      expect(find.text('Deutsch'), findsOneWidget);
    });
  });
}
