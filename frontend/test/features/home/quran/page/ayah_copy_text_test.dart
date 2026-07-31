import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/recitation_words.dart';
import 'package:tajweed_ai/src/helpers/quran_text_parser.dart';

/// Mirrors how `_PageViewerState._getAyahText` turns the raw `words.text`
/// values of one verse into the string put on the clipboard.
String copyText(List<String> words) => words
    .map(QuranTextParser.stripGlyphSigns)
    .where(arabicLetter.hasMatch)
    .join(' ');

/// 1:1:5 as stored in `words.text`: a pause sign plus the PUA number ornament.
const verseEndMarker = '۟';

void main() {
  group('stripGlyphSigns', () {
    test('leaves a plain word untouched', () {
      expect(QuranTextParser.stripGlyphSigns('بِسْمِ'), 'بِسْمِ');
    });

    test('keeps the word and drops a trailing PUA ornament', () {
      // 24:1:6 as stored — a real word carrying a PUA sign. The old code
      // dropped the whole word, losing Quran text from the copy.
      expect(QuranTextParser.stripGlyphSigns('اٰیٰتٍ'), 'اٰیٰتٍ');
    });

    test('reduces a verse-end marker to its bare pause sign', () {
      expect(QuranTextParser.stripGlyphSigns(verseEndMarker), '۟');
    });

    test('keeps embedded waqf marks, which are part of the printed text', () {
      expect(QuranTextParser.stripGlyphSigns('هُوَ ۚ'), 'هُوَ ۚ');
    });
  });

  group('copied ayah text', () {
    test('assembles Al-Fatiha 1:1 without the verse-end marker', () {
      expect(
        copyText([
          'بِسْمِ',
          'اللّٰهِ',
          'الرَّحْمٰنِ',
          'الرَّحِیْمِ',
          verseEndMarker,
        ]),
        'بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِیْمِ',
      );
    });

    test('includes words that carry a PUA sign', () {
      expect(
        copyText(['وَاَنْزَلْنَا', 'فِیْهَاۤ', 'اٰیٰتٍ', verseEndMarker]),
        'وَاَنْزَلْنَا فِیْهَاۤ اٰیٰتٍ',
      );
    });

    test('yields an empty string for glyph-only input', () {
      // What a pre-refresh app.db returns: the `text` column held QCF glyph
      // codes (Arabic Presentation Forms), so nothing survives the filter and
      // the copy is a no-op rather than pasting unreadable glyphs.
      expect(copyText(['ﱁ', 'ﱂ', 'ﱃ']), isEmpty);
    });
  });
}
