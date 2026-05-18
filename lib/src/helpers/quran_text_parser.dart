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
