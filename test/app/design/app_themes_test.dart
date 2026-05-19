import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/themes/app_themes.dart';

void main() {
  group('AppThemes', () {
    testWidgets('light theme builds a MaterialApp without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppThemes.light,
          home: const Scaffold(body: Text('light')),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('light'), findsOneWidget);
    });

    testWidgets('dark theme builds a MaterialApp without errors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppThemes.light,
          darkTheme: AppThemes.dark,
          themeMode: ThemeMode.dark,
          home: const Scaffold(body: Text('dark')),
        ),
      );
      expect(tester.takeException(), isNull);
      expect(find.text('dark'), findsOneWidget);
    });

    test('dark scheme is brightness=dark and primary stays gold', () {
      expect(AppThemes.dark.brightness, Brightness.dark);
      expect(AppThemes.dark.colorScheme.primary, AppColors.primary);
      expect(AppThemes.dark.scaffoldBackgroundColor, AppColors.darkScaffold);
    });

    test('light and dark share the same primary brand color', () {
      expect(
        AppThemes.dark.colorScheme.primary,
        AppThemes.light.colorScheme.primary,
      );
    });
  });
}
