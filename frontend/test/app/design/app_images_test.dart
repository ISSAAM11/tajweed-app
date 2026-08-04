import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_ai/src/app/index.dart';

/// A missing asset only surfaces at runtime, as a broken image on the screen —
/// renaming a file without updating its [AppImages] constant is an easy miss.
/// These paths are relative to the package root, which is the working directory
/// when `flutter test` runs.
void main() {
  group('AppImages', () {
    const paths = <String, String>{
      'tajweedLessonsIcon': AppImages.tajweedLessonsIcon,
      'quranRecitationIcon': AppImages.quranRecitationIcon,
      'tajweedTestIcon': AppImages.tajweedTestIcon,
      'quranHifthIcon': AppImages.quranHifthIcon,
      'backgroundLastRead': AppImages.backgroundLastRead,
      'surahNumberBackground': AppImages.surahNumberBackground,
      'lastReadIcon': AppImages.lastReadIcon,
      'quranImage': AppImages.quranImage,
      'hifthTitleBackground': AppImages.hifthTitleBackground,
      'hifthBismillah': AppImages.hifthBismillah,
      'hifthWaveform': AppImages.hifthWaveform,
    };

    paths.forEach((name, path) {
      test('$name points at a file that exists', () {
        expect(
          File(path).existsSync(),
          isTrue,
          reason: 'AppImages.$name -> "$path" is not on disk',
        );
      });
    });
  });
}
