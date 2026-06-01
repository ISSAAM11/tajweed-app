part of '../app_metrics.dart';

class _Drawer {
  const _Drawer._();

  final double width = 0;
  final double radius = 10;
}

class _Cards {
  const _Cards._();

  final double elevation = AppMetrics.defaultElevation;
  final double radius = 8;
  final double iconSize = 36;
}

class _ListTiles {
  const _ListTiles._();

  final double radius = AppMetrics.defaultRadius;
}

class _ProgressIndicators {
  const _ProgressIndicators._();

  final double circularStrokeWidth = 1.5;
  final double linearMinHeight = 4;
  final double downloadCircularColorSize = 45;
}

class _FilePicking {
  _FilePicking._();

  static const int sizeLimit = 5;
  final int sizeLimitInBytes = sizeLimit * 1024 * 1024;
  final int imageQuality = 60;
  final List<String> extensions = ['jpeg', 'jpg', 'png', 'pdf'];
}

class _LastSelectedSurahWidget {
  const _LastSelectedSurahWidget._();

  final double height = 150;
  final double borderRadius = 20;
  final EdgeInsets containerPadding = const EdgeInsets.all(2);
  final EdgeInsets contentPadding = const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 16,
  );
  final EdgeInsets margin = const EdgeInsets.symmetric(
    horizontal: 25,
    vertical: 8,
  );

  // Icon sizes
  final double lastReadIconSize = 20;
  final double quranImageSize = 165;
  final double continueButtonIconSize = 16;

  // Spacing
  final double columnSpacing = 7;
  final double iconTextSpacing = 5;
  final double buttonIconSpacing = 6;

  // Button metrics
  final double buttonBorderRadius = 30;
  final EdgeInsets buttonPadding = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 4,
  );
}

class _QuranPageViewer {
  const _QuranPageViewer._();

  final double surahHeaderHeight = 42;
  final double surahHeaderBottomPadding = 2;
  final double contentHorizontalMargin = 8;
  final double backgroundResizeHeight = 110;

  // Ayah popup
  final double popupWidth = 190;
  final double popupHeight = 40;
  final double popupRadius = 25;
  final double popupIconSize = 22;
  final double popupElevation = 8;
}

class _HomeScreen {
  const _HomeScreen._();

  // Dark shelf under the AppBar
  final double darkShelfHeight = 40;
  final double darkShelfBottomRadius = 30;

  // Horizontal padding of the body
  final EdgeInsets bodyPadding = const EdgeInsets.symmetric(horizontal: 16);
  final EdgeInsets bodyPaddingSubtitle = const EdgeInsets.symmetric(
    horizontal: 8,
  );

  // Vertical gap between the last-reading card and the section title
  final double sectionTopSpacing = 24;
  final double sectionBottomSpacing = 16;

  // Grid
  final double gridCrossSpacing = 14;
  final double gridMainSpacing = 14;
  final double gridChildAspectRatio = 0.95;
}

class _HomeActionCard {
  const _HomeActionCard._();

  final double radius = 24;
  final EdgeInsets contentPadding = const EdgeInsets.all(16);

  final double iconSize = 64;
  final double titleSpacing = 8;
  final double badgeSpacing = 10;

  final EdgeInsets badgePadding = const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 4,
  );
  final double badgeRadius = 20;

  final double progressBarHeight = 4;
  final double progressBarRadius = 2;
  final double progressBarSpacing = 6;
  final double progressLabelSpacing = 4;

  final double borderWidth = 1;
}

class _SettingsScreen {
  const _SettingsScreen._();

  final EdgeInsets bodyPadding = const EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 24,
  );
  final EdgeInsets sectionTitlePadding = const EdgeInsets.only(
    left: 4,
    right: 4,
    bottom: 12,
  );

  final double optionRowHeight = 64;
  final double optionRowRadius = 16;
  final EdgeInsets optionRowPadding = const EdgeInsets.symmetric(
    horizontal: 16,
  );
  final double optionRowBorderWidth = 1.5;

  final double selectionIconSize = 22;
  final double optionGap = 12;
}

class _ComingSoonTile {
  const _ComingSoonTile._();

  final double rowHeight = 64;
  final double rowRadius = 16;
  final EdgeInsets rowPadding = const EdgeInsets.symmetric(horizontal: 16);
  final double rowBorderWidth = 1.5;

  final double iconSize = 22;
  final double iconTextSpacing = 12;

  final EdgeInsets badgePadding = const EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 4,
  );
  final double badgeRadius = 12;
}

class _AudioBar {
  const _AudioBar._();

  final double height = 60;
  final double iconSize = 26;
  final double stopIconSize = 20;
  final double progressBarHeight = 2;
  final EdgeInsets padding = const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 8,
  );
  final double infoFontSize = 13;
  final double verseFontSize = 11;
  final double borderRadius = 18;
  final double horizontalMargin = 12;
  final double bottomMargin = 16;
  final double backgroundOpacity = 0.90;
  final double overlayOpacity = 0.18;
  final double blurSigma = 12.0;
  final double elevation = 12;
}

class _SurahNameCard {
  const _SurahNameCard._();

  // Padding
  final EdgeInsets cardPadding = const EdgeInsets.symmetric(
    horizontal: 30,
    vertical: 15,
  );

  // Number container
  final double numberContainerSize = 36;
  final double numberFontSize = 14;

  // Spacing
  final double numberTextSpacing = 20;

  // Text sizes
  final double englishNameFontSize = 16;
  final double metadataFontSize = 12;
  final double arabicNameFontSize = 21;
}
