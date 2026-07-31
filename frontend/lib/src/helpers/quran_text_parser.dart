// quran_text_parser.dart
import 'package:html/parser.dart' as html;

/// Regex for Arabic waqf/pause signs
const _waqfSigns = ['ۗ', 'ۘ', 'ۚ', 'ۛ', 'ۜ', 'ۖ'];
// Arabic-Indic digits ٠١٢٣٤٥٦٧٨٩
final arabicDigits = RegExp(r'[\u0660-\u0669]');

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
