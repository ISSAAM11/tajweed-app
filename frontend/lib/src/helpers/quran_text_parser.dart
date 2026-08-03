// quran_text_parser.dart
import 'package:html/parser.dart' as html;

/// Regex for Arabic waqf/pause signs
const _waqfSigns = ['ۗ', 'ۘ', 'ۚ', 'ۛ', 'ۜ', 'ۖ'];
// Arabic-Indic digits ٠١٢٣٤٥٦٧٨٩
final arabicDigits = RegExp(r'[\u0660-\u0669]');

// \u2500\u2500 IndoPak \u2192 Uthmanic script conversion. See [QuranTextParser.toUthmanicScript]
const _farsiYeh = 0x06CC;
const _arabicYeh = 0x064A;

/// IndoPak-only marks that KFGQPC Uthmanic Hafs renders as a placeholder blob:
/// takhallus, small high tah / zain, small v above, small high rounded zero and
/// the empty-centre high stop.
const _indopakOnlySigns = <int>{
  0x0614,
  0x0615,
  0x0617,
  0x065A,
  0x06DF,
  0x06EB,
};

final _repeatedWhitespace = RegExp(r'\s+');

class QuranTextParser {
  /// Strip all HTML tags / `<rule>` tags from a single string
  static String stripRules(String input) {
    final document = html.parseFragment(input);
    return document.text ?? '';
  }

  /// Strip rules from a list of words
  static List<String> stripRulesList(List<String> words) {
    return words.map(stripRules).toList();
  }

  /// Removes Arabic ayah numbers (٠١٢٣٤٥٦٧٨٩)
  static String removeAyahNumbers(String input) {
    return input.replaceAll(arabicDigits, '');
  }

  static List<String> removeAyahNumbersList(List<String> words) {
    return words.map(removeAyahNumbers).toList();
  }

  /// Removes Private-Use-Area codepoints (U+E000–U+F8FF) from a word.
  ///
  /// In `words.text` some words carry a trailing ornament sign in the PUA, and
  /// verse-end markers are stored as a PUA number ornament. Those are codes for
  /// the mushaf font, not readable Arabic.
  ///
  /// Stripping rather than discarding the whole word keeps real words that
  /// merely carry a sign; a verse-end marker strips down to a bare pause sign,
  /// which callers drop by testing the result for an Arabic letter.
  static String stripGlyphSigns(String word) => String.fromCharCodes(
    word.runes.where((r) => r < 0xE000 || r > 0xF8FF),
  ).trim();

  /// Rewrites IndoPak-encoded mushaf text so KFGQPC Uthmanic Hafs can draw it.
  ///
  /// `words.text` is stored in the IndoPak convention, but the app renders it
  /// with `AppFonts.uthmanicHafsFont`. That font maps 170 IndoPak-only
  /// codepoints to a placeholder outline rather than leaving them unmapped, so
  /// Flutter's font fallback never triggers and they paint as filled blobs
  /// instead of letters. The text therefore has to be converted, not fallen
  /// back on. Two cases:
  ///
  /// - **Farsi Yeh (U+06CC)** is the IndoPak spelling of Yeh; the Uthmanic
  ///   script uses U+064A. The mapping is unambiguous because the DB already
  ///   stores Alef Maksura separately as U+0649.
  /// - **IndoPak-only waqf signs** have no counterpart in the Madani mushaf
  ///   (there is no Uthmanic codepoint for waqf mutlaq, for instance), so they
  ///   are dropped rather than mapped to a sign that means something else.
  ///   They are pause guidance, not letters or vowels — the words themselves
  ///   are untouched.
  static String toUthmanicScript(String input) {
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      if (_indopakOnlySigns.contains(rune)) continue;
      buffer.writeCharCode(rune == _farsiYeh ? _arabicYeh : rune);
    }
    // Dropping a sign leaves the space that separated it from the word.
    return buffer.toString().replaceAll(_repeatedWhitespace, ' ').trim();
  }

  /// Cut a string or words list at the first waqf/pause sign
  static String cutAtFirstWaqf(String text) {
    for (final sign in _waqfSigns) {
      final idx = text.indexOf(sign);
      if (idx != -1) {
        return text.substring(0, idx + 1);
      }
    }
    return text;
  }

  static List<String> cutWordsAtFirstWaqf(List<String> words) {
    List<String> result = [];
    for (final word in words) {
      result.add(word);
      for (final sign in _waqfSigns) {
        if (word.contains(sign)) {
          return result;
        }
      }
    }
    return result;
  }
}
