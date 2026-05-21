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

    test('dark scheme is brightness=dark and primary is dark-mode gold', () {
      expect(AppThemes.dark.brightness, Brightness.dark);
      expect(AppThemes.dark.colorScheme.primary, AppColors.darkPrimary);
      expect(AppThemes.dark.scaffoldBackgroundColor, AppColors.darkScaffold);
    });

    test('light and dark both use gold-family primaries (brand consistency)', () {
      // Light uses the rich gold #D4AF37; dark uses a brighter #F2CA50 for luminance on obsidian.
      // Dark's primaryContainer holds the light-mode gold so the brand color is never lost.
      expect(AppThemes.light.colorScheme.primary, AppColors.primary);
      expect(AppThemes.dark.colorScheme.primary, AppColors.darkPrimary);
      expect(AppThemes.dark.colorScheme.primaryContainer, AppColors.darkPrimaryContainer);
      expect(AppColors.darkPrimaryContainer, AppColors.primary);
    });

    test('dark scheme wires the obsidian surface tiers', () {
      final scheme = AppThemes.dark.colorScheme;
      expect(scheme.surface, AppColors.darkScaffold);
      expect(scheme.surfaceContainer, AppColors.darkSurface);
      expect(scheme.surfaceContainerHigh, AppColors.darkSurfaceVariant);
      expect(scheme.surfaceContainerLowest, AppColors.darkSurfaceContainerLowest);
      expect(scheme.surfaceContainerHighest, AppColors.darkSurfaceContainerHighest);
      expect(scheme.onSurface, AppColors.darkTextPrimary);
      expect(scheme.onSurfaceVariant, AppColors.darkTextSecondary);
    });

    test('dark scheme wires the outline tokens and dark error', () {
      final scheme = AppThemes.dark.colorScheme;
      expect(scheme.outline, AppColors.darkOutline);
      expect(scheme.outlineVariant, AppColors.darkBorder);
      expect(scheme.error, AppColors.darkError);
      expect(scheme.onError, AppColors.darkOnError);
    });

    test('AppBar stays greyDarkest in both light and dark (brand signature)', () {
      expect(
        AppThemes.dark.appBarTheme.backgroundColor,
        AppThemes.light.appBarTheme.backgroundColor,
      );
      expect(AppThemes.dark.appBarTheme.backgroundColor, AppColors.greyDarkest);
    });
  });
}
