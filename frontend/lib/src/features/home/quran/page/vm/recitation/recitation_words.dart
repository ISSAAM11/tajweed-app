import 'package:tajweed_ai/src/features/home/quran/page/datasource/page_models.dart';

/// Arabic base-letter ranges — same set the recitation use cases filter by, so
/// marker-only words (waqf / ayah-end ornaments) are excluded and the indices
/// line up with the backend verdicts.
///
/// Also used to tell real words from ornament-only ones when copying an ayah
/// (see `_PageViewerState._getAyahText`).
final arabicLetter = RegExp('[ء-غف-يٮ-ۓ]');

/// The ordered recitable words actually rendered on [page] (each `WordRow.id`
/// with its plain `text`), filtered to real Arabic words.
///
/// If [fromSurah]/[fromAyah] are given, words before that verse are skipped —
/// used by the FAB to start recitation from a specific selected position.
List<({int id, String text})> recitableWordsFromPage(
  PageContentDto page, {
  int? fromSurah,
  int? fromAyah,
}) {
  final words = <({int id, String text})>[];
  var started = fromSurah == null || fromAyah == null;

  for (final block in page.blocks) {
    if (block is! LineWordsBlockDto) continue;
    for (final word in block.lineWords) {
      if (!started && word.surah == fromSurah && word.ayah == fromAyah) {
        started = true;
      }
      if (!started) continue;
      if (!arabicLetter.hasMatch(word.plainText)) continue;
      words.add((id: word.id, text: word.plainText));
    }
  }
  return words;
}

/// The largest surah number appearing on [page] (used to compute "next surah").
int? maxSurahOnPage(PageContentDto page) {
  int? max;
  for (final block in page.blocks) {
    if (block is! LineWordsBlockDto) continue;
    for (final word in block.lineWords) {
      if (max == null || word.surah > max) max = word.surah;
    }
  }
  return max;
}
