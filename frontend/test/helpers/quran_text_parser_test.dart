import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_ai/src/helpers/quran_text_parser.dart';

/// Every codepoint KFGQPC Uthmanic Hafs cannot draw. The font maps these to a
/// placeholder outline rather than leaving them unmapped, so Flutter's font
/// fallback never rescues them — [QuranTextParser.toUthmanicScript] must remove
/// or convert all of them.
const _unrenderable = {0x0614, 0x0615, 0x0617, 0x065A, 0x06CC, 0x06DF, 0x06EB};

void main() {
  group('toUthmanicScript', () {
    test('converts Farsi Yeh to Arabic Yeh', () {
      // فَسِيحُوا — IndoPak spells the Yeh as U+06CC.
      expect(
        QuranTextParser.toUthmanicScript('فَسِی'),
        'فَسِي',
      );
    });

    test('leaves Alef Maksura alone so it stays distinct from Yeh', () {
      expect(
        QuranTextParser.toUthmanicScript('عَلَى'),
        'عَلَى',
      );
    });

    test('drops IndoPak-only waqf signs and the space they left behind', () {
      // وَالْأَرْحَامَ ؕ — the pause sign is a separate space-delimited token.
      expect(
        QuranTextParser.toUthmanicScript('مَ ؕ'),
        'مَ',
      );
    });

    test('keeps Uthmanic waqf signs the font does support', () {
      expect(
        QuranTextParser.toUthmanicScript('مَ ۙ'),
        'مَ ۙ',
      );
    });

    test('emits nothing the Uthmanic Hafs font cannot render', () {
      const sample =
          'فَسِیْ ؕ ۟ ۫ ا';
      final out = QuranTextParser.toUthmanicScript(sample);
      expect(
        out.runes.where(_unrenderable.contains),
        isEmpty,
        reason: 'converted text still contains a codepoint that renders as a '
            'placeholder blob',
      );
    });
  });
}
