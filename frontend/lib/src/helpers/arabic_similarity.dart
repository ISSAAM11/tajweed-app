/// Similarity scoring between two Arabic texts, tolerant to diacritics and
/// orthographic variants. Used by the tajweed test to compare the ASR
/// transcription of the user's recitation against the expected ayah text.
library;

/// Strips tashkeel and unifies letter variants so that two renderings of the
/// same recitation compare equal.
String normalizeArabic(String input) {
  final buffer = StringBuffer();
  for (final rune in input.runes) {
    // Tashkeel (fatha, damma, kasra, sukun, shadda, tanween...), Quranic
    // annotation marks and tatweel are dropped entirely.
    if ((rune >= 0x064B && rune <= 0x065F) ||
        (rune >= 0x06D6 && rune <= 0x06ED) ||
        rune == 0x0670 ||
        rune == 0x0640) {
      continue;
    }
    buffer.writeCharCode(switch (rune) {
      0x0622 || 0x0623 || 0x0625 || 0x0671 => 0x0627, // آ أ إ ٱ -> ا
      0x0649 => 0x064A, // ى -> ي
      0x0624 => 0x0648, // ؤ -> و
      0x0626 => 0x064A, // ئ -> ي
      0x0629 => 0x0647, // ة -> ه
      _ => rune,
    });
  }
  // Collapse whitespace runs.
  return buffer.toString().trim().replaceAll(RegExp(r'\s+'), ' ');
}

/// Returns a similarity ratio in [0, 1] between the normalized forms of
/// [expected] and [actual], based on character-level Levenshtein distance.
double arabicSimilarity(String expected, String actual) {
  final a = normalizeArabic(expected);
  final b = normalizeArabic(actual);
  if (a.isEmpty && b.isEmpty) return 1;
  if (a.isEmpty || b.isEmpty) return 0;
  final distance = _levenshtein(a, b);
  final maxLen = a.length > b.length ? a.length : b.length;
  return 1 - distance / maxLen;
}

int _levenshtein(String a, String b) {
  var previous = List<int>.generate(b.length + 1, (i) => i);
  var current = List<int>.filled(b.length + 1, 0);
  for (var i = 1; i <= a.length; i++) {
    current[0] = i;
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      current[j] = [
        previous[j] + 1,
        current[j - 1] + 1,
        previous[j - 1] + cost,
      ].reduce((x, y) => x < y ? x : y);
    }
    final tmp = previous;
    previous = current;
    current = tmp;
  }
  return previous[b.length];
}
