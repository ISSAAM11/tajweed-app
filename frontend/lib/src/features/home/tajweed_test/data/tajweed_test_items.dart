/// One tajweed test: a short ayah that showcases a single rule.
class TajweedTestItem {
  /// Rule key resolved to a localized title in the view
  /// (matches the tajweed_courses l10n keys: qalqala, idgham, ikhfa...).
  final String ruleKey;
  final int surah;
  final int ayah;

  /// Ayah text with tashkeel, displayed to the user (Uthmanic font).
  final String displayText;

  /// Minimum similarity ratio (0..1) between the ASR transcription and
  /// [displayText] for the recitation to be accepted.
  final double threshold;

  const TajweedTestItem({
    required this.ruleKey,
    required this.surah,
    required this.ayah,
    required this.displayText,
    this.threshold = 0.8,
  });
}

/// Hardcoded v1 test set — short ayahs, one prominent rule each.
const tajweedTestItems = <TajweedTestItem>[
  TajweedTestItem(
    ruleKey: 'qalqala',
    surah: 112,
    ayah: 1,
    displayText: 'قُلْ هُوَ اللَّهُ أَحَدٌ',
  ),
  TajweedTestItem(
    ruleKey: 'idgham',
    surah: 112,
    ayah: 4,
    displayText: 'وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ',
  ),
  TajweedTestItem(
    ruleKey: 'ikhfa',
    surah: 114,
    ayah: 4,
    displayText: 'مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ',
  ),
];
