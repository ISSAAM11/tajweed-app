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

  final double height = 160;
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
