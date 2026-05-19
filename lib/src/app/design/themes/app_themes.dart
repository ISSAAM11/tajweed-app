import 'package:flutter/material.dart';

import '../../index.dart';

final class AppThemes {
  //? LIGHT THEME
  static final ThemeData light = ThemeData(
    applyElevationOverlayColor: true,
    useMaterial3: true,

    colorScheme: const ColorScheme.light(
      surface: AppColors.scaffold,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      shadow: AppColors.shadow,
      tertiary: AppColors.tertiary,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: AppColors.greyDark,
      onSurface: AppColors.greyDark,
    ),
    scaffoldBackgroundColor: AppColors.scaffold,

    //! Primary Icon
    primaryIconTheme: const IconThemeData(color: AppColors.primary),
    iconTheme: const IconThemeData(color: AppColors.primary),

    //! App Bar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.greyDarkest,
      elevation: AppMetrics.topBar.elevation,
      toolbarHeight: AppMetrics.topBar.height,
      shadowColor: AppColors.shadow,
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: AppFonts.nunito
          .semiBold()
          .withSize(FontSizes.headline2)
          .withColor(Colors.white),
    ),

    //$ Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppMetrics.buttons.elevated.elevation,
        shadowColor: AppColors.shadow,
        minimumSize: Size.fromHeight(AppMetrics.buttons.elevated.height),
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppMetrics.buttons.radius),
          ),
        ),
        textStyle: AppFonts.helvetica.bold().withSize(FontSizes.headline3),
        foregroundColor: Colors.white,
      ),
    ),

    //@ Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: AppMetrics.buttons.elevated.elevation,
        shadowColor: AppColors.shadow,
        minimumSize: Size.fromHeight(AppMetrics.buttons.text.height),
        backgroundColor: AppColors.scaffold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppMetrics.buttons.radius),
          ),
        ),
        textStyle: AppFonts.helvetica.bold().withSize(FontSizes.title),
        foregroundColor: AppColors.primary,
      ),
    ),

    //! Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: AppMetrics.buttons.floating.elevation,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      iconSize: AppMetrics.buttons.floating.iconSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppMetrics.buttons.floating.radius),
        ),
      ),
    ),

    //! Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.divider,
      thickness: 1,
      space: 1,
    ),

    //? Inputs
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppMetrics.inputs.horizontalContentPadding,
        vertical: AppMetrics.inputs.verticalContentPadding,
      ),
      errorMaxLines: 3,
      prefixIconColor: AppColors.greyDark,
      suffixIconColor: AppColors.greyDark,
      alignLabelWithHint: true,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.disabledColor,
          width: AppMetrics.inputs.borderWidth,
        ),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.inputBorder,
          width: AppMetrics.inputs.borderWidth,
        ),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.primary,
          width: AppMetrics.inputs.borderWidth,
        ),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppMetrics.inputs.borderWidth,
        ),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.error,
          width: AppMetrics.inputs.borderWidth,
        ),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      filled: true,
      fillColor: AppColors.greyBackground,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      contentTextStyle: AppFonts.helvetica.withSize(FontSizes.subtitle),
    ),

    //! Card
    cardTheme: CardThemeData(
      color: AppColors.greyBackground,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.shadow,
      elevation: AppMetrics.cards.elevation,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppMetrics.cards.radius),
        ),
      ),
    ),

    //! List Tile
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.primary,
      textColor: AppColors.greyDark,
      titleAlignment: ListTileTitleAlignment.top,
      titleTextStyle: AppFonts.helvetica.bold().withSize(FontSizes.headline3),
      subtitleTextStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .withHeight(1.3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 12,
      minVerticalPadding: 20,
      style: ListTileStyle.list,
      enableFeedback: true,
      tileColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.cards.radius),
      ),
    ),

    //! Checkbox
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(Colors.white),
      fillColor: WidgetStateProperty.all(AppColors.primary),
      side: const BorderSide(color: AppColors.primary),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ),

    //! Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearMinHeight: AppMetrics.progressIndicators.linearMinHeight,
      strokeWidth: AppMetrics.progressIndicators.circularStrokeWidth,
      color: AppColors.primary,
      linearTrackColor: AppColors.secondary,
      refreshBackgroundColor: AppColors.secondary,
      circularTrackColor: AppColors.secondary,
    ),

    //! Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.greyDark,
        borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
      ),
      enableFeedback: true,
      textStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .semiBold()
          .withColor(Colors.white),
    ),

    //! SnackBar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
      ),
      elevation: AppMetrics.defaultElevation,
    ),

    //! Chip
    chipTheme: ChipThemeData(
      padding: EdgeInsets.zero,
      elevation: AppMetrics.defaultElevation,
      labelPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMetrics.defaultRadius + 2),
      ),
      side: const BorderSide(color: AppColors.primary),
      shadowColor: AppColors.shadow,
      backgroundColor: AppColors.scaffold,
      labelStyle: AppFonts.helvetica.withSize(FontSizes.subtitle).semiBold(),
      deleteIconColor: AppColors.primary,
    ),
  );

  static final ThemeData dark = light.copyWith(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: AppColors.darkSurface,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      tertiary: AppColors.tertiary,
      shadow: AppColors.shadow,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: AppColors.greyDark,
      onSurface: AppColors.darkTextPrimary,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.darkScaffold,
    canvasColor: AppColors.darkSurface,

    //! App Bar — keep dark grey background (same as light) so brand stays consistent
    appBarTheme: light.appBarTheme.copyWith(
      backgroundColor: AppColors.greyDarkest,
    ),

    //! Card — darker surface, no shadow tint
    cardTheme: light.cardTheme.copyWith(
      color: AppColors.darkSurface,
    ),

    //! Divider
    dividerTheme: const DividerThemeData(
      color: AppColors.darkBorder,
      thickness: 1,
      space: 1,
    ),

    //! Inputs — dark surface variant fill, gold focus border (brand)
    inputDecorationTheme: light.inputDecorationTheme.copyWith(
      fillColor: AppColors.darkSurfaceVariant,
      prefixIconColor: AppColors.darkTextSecondary,
      suffixIconColor: AppColors.darkTextSecondary,
      hintStyle: AppFonts.lato
          .withSize(FontSizes.subtitle)
          .withColor(AppColors.darkTextSecondary),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.darkBorder,
          width: AppMetrics.inputs.borderWidth,
        ),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
    ),

    //! Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      surfaceTintColor: Colors.transparent,
      contentTextStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .withColor(AppColors.darkTextPrimary),
    ),

    //! List Tile
    listTileTheme: light.listTileTheme.copyWith(
      iconColor: AppColors.primaryLight,
      textColor: AppColors.darkTextPrimary,
      titleTextStyle: AppFonts.helvetica
          .bold()
          .withSize(FontSizes.headline3)
          .withColor(AppColors.darkTextPrimary),
      subtitleTextStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .withHeight(1.3)
          .withColor(AppColors.darkTextSecondary),
    ),

    //! Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: AppColors.darkSurfaceVariant,
        borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
      ),
      enableFeedback: true,
      textStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .semiBold()
          .withColor(AppColors.darkTextPrimary),
    ),

    //! SnackBar
    snackBarTheme: light.snackBarTheme.copyWith(
      backgroundColor: AppColors.darkSurfaceVariant,
      contentTextStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .withColor(AppColors.darkTextPrimary),
    ),

    //! Chip
    chipTheme: light.chipTheme.copyWith(
      backgroundColor: AppColors.darkSurface,
      labelStyle: AppFonts.helvetica
          .withSize(FontSizes.subtitle)
          .semiBold()
          .withColor(AppColors.darkTextPrimary),
    ),

    //! Text Button — gold text on transparent for dark
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: AppMetrics.buttons.elevated.elevation,
        shadowColor: AppColors.shadow,
        minimumSize: Size.fromHeight(AppMetrics.buttons.text.height),
        backgroundColor: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppMetrics.buttons.radius),
          ),
        ),
        textStyle: AppFonts.helvetica.bold().withSize(FontSizes.title),
        foregroundColor: AppColors.primaryLight,
      ),
    ),
  );
}
