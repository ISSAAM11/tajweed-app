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
  static const Color bottomBarDarkColor = Color(0xFF1A1A1A);
  static const Color scaffold = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

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
