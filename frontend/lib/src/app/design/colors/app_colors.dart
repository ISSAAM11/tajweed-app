import 'package:flutter/material.dart';

abstract final class AppColors {
  // Elegant Gold Primary Colors
  static const Color primary = Color(0xFFD4AF37); // Rich Gold
  static const Color primaryLight = Color(0xFFE6C866); // Light Gold
  static const Color primaryDark = Color(0xFFB8941F); // Dark Gold
  static const Color secondary = Color(0xFFF4E4BC); // Cream Gold
  static const Color tertiary = Color(0xFF8B7355); // Warm Brown

  // Elegant Gold Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryLight, primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.5, 1.0],
  );

  static const LinearGradient shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFF4E4BC), // Cream
      Color(0xFFE6C866), // Light Gold
      Color(0xFFD4AF37), // Rich Gold
      Color(0xFFE6C866), // Light Gold
      Color(0xFFF4E4BC), // Cream
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, primaryLight, primary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [primaryDark, primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Subtle Highlight Gradients
  static const LinearGradient highlightGradient = LinearGradient(
    colors: [
      Colors.white,
      Color(0xFFF4E4BC),
      Color(0xFFE6C866),
      Color(0xFFD4AF37),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.3, 0.7, 1.0],
  );

  // Neutral Colors
  static const Color greyDarkest = Color(0xFF413E40); // New color
  static const Color greyDark = Color(0xFF2C2C2C);
  static const Color greyMedium = Color(0xFF555555);
  static const Color greyRegular = Color(0xFF6D7475);
  static const Color greyLight = Color(0xFFE1E2E5);
  static const Color greyBackground = Color(0xFFF8F9FA);
  static const Color divider = Color(0xFFE0E0E0);
  static const Color inputBorder = Color(0xFFD4AF37);

  // Accent Colors
  static const Color toolTip = Color(0xFFF8F3E6);
  static const Color accent = Color(0xFF8B7355); // Warm Brown Accent

  // Background Colors
  static const Color bottomBarColor = greyBackground;
  static const Color bottomBarDarkColor = Color(0xFF131313); // matches darkScaffold
  static const Color scaffold = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  // Dark Theme Surfaces — "Serene Tajweed Night" spec (DESIGN-DARK-MODE.md)
  // Obsidian-tiered surfaces with warm cream-on-dark text.
  static const Color darkScaffold = Color(0xFF131313); // spec: surface / background
  static const Color darkSurface = Color(0xFF201F1F); // spec: surface-container — cards, dialogs, snackbars
  static const Color darkSurfaceVariant = Color(0xFF2A2A2A); // spec: surface-container-high — input fills, tooltips
  static const Color darkBorder = Color(0xFF4D4635); // spec: outline-variant — dividers, unfocused borders
  static const Color darkTextPrimary = Color(0xFFE5E2E1); // spec: on-surface — warm cream, less eye strain than pure white
  static const Color darkTextSecondary = Color(0xFFD0C5AF); // spec: on-surface-variant — warm cream tint, secondary text
  // Extra dark surface tiers (spec)
  static const Color darkSurfaceContainerLowest = Color(0xFF0E0E0E);
  static const Color darkSurfaceContainerLow = Color(0xFF1C1B1B);
  static const Color darkSurfaceContainerHighest = Color(0xFF353534);
  static const Color darkSurfaceBright = Color(0xFF393939);
  static const Color darkOutline = Color(0xFF99907C); // spec: outline — stronger borders, decorative lines
  // Dark-mode brand variants — gold gets a touch more luminance against obsidian
  static const Color darkPrimary = Color(0xFFF2CA50); // spec: primary in dark — brighter gold for contrast
  static const Color darkOnPrimary = Color(0xFF3C2F00); // spec: on-primary
  static const Color darkPrimaryContainer = Color(0xFFD4AF37); // the light-mode gold becomes the container in dark
  // Dark-mode error
  static const Color darkError = Color(0xFFFFB4AB); // spec: error in dark — softer red that reads on obsidian
  static const Color darkOnError = Color(0xFF690005); // spec: on-error

  // Quran page colors
  static const Color ayahHighlight = Color(0x4DFFC107);   // amber 30% opacity
  static const Color ayahMarked = Color(0x4D6D7475);      // greyRegular 30% — marked ayah, light theme
  static const Color ayahMarkedDark = Color(0x38FFFFFF);  // white 22% — marked ayah, dark theme
  static const Color surahGlyphColor = Color(0xB7000000); // black 72% opacity

  // Interactive Colors
  static const Color splashColor = Color(0x1AD4AF37);
  static const Color focusColor = Color(0x1A8B7355);
  static const Color overlayColor = Color(0x0D2C2C2C);
  static const Color inactiveColor = Color(0xA7D4AF37);
  static const Color disabledColor = Color(0xFFF5F5F5);
  static const Color hint = greyRegular;
  static const Color shadow = Color(0x1A000000);

  // Status Colors
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF39C12);
  static const Color success = Color(0xFF27AE60);
  static const Color info = Color(0xFF3498DB);
}
