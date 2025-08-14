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
      tertiary: AppColors.warning,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.scaffold,

    //! Primary Icon
    primaryIconTheme: const IconThemeData(color: AppColors.error),
    iconTheme: const IconThemeData(color: AppColors.primary),

    //! App Bar
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      elevation: AppMetrics.topBar.elevation,
      toolbarHeight: AppMetrics.topBar.height,
      shadowColor: AppColors.shadow,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.primary),
      titleTextStyle: AppFonts.nunito
          .semiBold()
          .withSize(FontSizes.headline2)
          .withColor(AppColors.scaffold),
    ),

    //$ Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: AppMetrics.buttons.elevated.elevation,
        shadowColor: AppColors.greyLight,
        minimumSize: Size.fromHeight(AppMetrics.buttons.elevated.height),
        backgroundColor: AppColors.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppMetrics.buttons.radius)),
        ),
        textStyle: AppFonts.helvetica.bold().withSize(FontSizes.headline3),
        foregroundColor: AppColors.scaffold,
      ),
    ),

    //@ Text Button
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        elevation: AppMetrics.buttons.elevated.elevation,
        shadowColor: AppColors.greyLight,
        minimumSize: Size.fromHeight(AppMetrics.buttons.text.height),
        backgroundColor: AppColors.scaffold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppMetrics.buttons.radius)),
        ),
        textStyle: AppFonts.helvetica.bold().withSize(FontSizes.title),
        foregroundColor: AppColors.primary,
      ),
    ),

    //! Floating Action Button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: AppMetrics.buttons.floating.elevation,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.scaffold,
      iconSize: AppMetrics.buttons.floating.iconSize,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(AppMetrics.buttons.floating.radius)),
      ),
    ),

    //! Divider
    dividerTheme: const DividerThemeData(color: AppColors.divider, thickness: 1, space: 1),

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
        borderSide: BorderSide(color: AppColors.secondary, width: AppMetrics.inputs.borderWidth),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.secondary, width: AppMetrics.inputs.borderWidth),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: AppMetrics.inputs.borderWidth),
        borderRadius: BorderRadius.circular(AppMetrics.inputs.radius),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.error, width: AppMetrics.inputs.borderWidth),
      ),
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
        borderRadius: BorderRadius.all(Radius.circular(AppMetrics.cards.radius)),
      ),
    ),

    //! List Tile
    listTileTheme: ListTileThemeData(
      iconColor: AppColors.primary,
      textColor: Colors.black,
      titleAlignment: ListTileTitleAlignment.top,
      titleTextStyle: AppFonts.helvetica.bold().withSize(FontSizes.headline3),
      subtitleTextStyle: AppFonts.helvetica.withSize(FontSizes.subtitle).withHeight(1.3),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 12,
      minVerticalPadding: 20,
      style: ListTileStyle.list,
      enableFeedback: true,
      tileColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppMetrics.cards.radius)),
    ),

    //! Checkbox
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.primary),
      fillColor: WidgetStateProperty.all(AppColors.tertiary),
      side: const BorderSide(color: AppColors.primary),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
    ),

    //! Progress Indicator
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearMinHeight: AppMetrics.progressIndicators.linearMinHeight,
      color: AppColors.primary,
      linearTrackColor: AppColors.secondary,
      refreshBackgroundColor: AppColors.secondary,
      circularTrackColor: AppColors.secondary,
    ),

    //! Tooltip
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        // color: AppColors.tertiaryShape,
        borderRadius: BorderRadius.circular(AppMetrics.defaultRadius),
      ),
      enableFeedback: true,
      textStyle: AppFonts.helvetica.withSize(FontSizes.subtitle).semiBold().withColor(Colors.white),
    ),

    //! SnackBar
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppMetrics.defaultRadius)),
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
      side: const BorderSide(color: Color.fromARGB(255, 23, 63, 90)),
      shadowColor: AppColors.shadow,
      backgroundColor: AppColors.scaffold,
      labelStyle: AppFonts.helvetica.withSize(FontSizes.subtitle).semiBold(),
      deleteIconColor: AppColors.primary,
    ),
  );

  static final ThemeData dark = light.copyWith(
    colorScheme: const ColorScheme.dark(
      surface: Colors.black54,
      primary: Colors.pink,
      secondary: AppColors.secondary,
      shadow: AppColors.shadow,
    ),
    scaffoldBackgroundColor: Colors.black45,
    textTheme: const TextTheme(),
    appBarTheme: light.appBarTheme.copyWith(
      color: AppColors.primary,
      titleTextStyle: light.appBarTheme.titleTextStyle,
      iconTheme: light.appBarTheme.iconTheme,
    ),
  );
}
