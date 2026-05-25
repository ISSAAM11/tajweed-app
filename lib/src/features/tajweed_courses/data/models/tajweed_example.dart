class TajweedExample {
  final String id;
  final String arabicText;
  final String referenceKey;
  final String transliterationKey;
  final String explanationKey;
  final String? audioAsset;

  const TajweedExample({
    required this.id,
    required this.arabicText,
    required this.referenceKey,
    required this.transliterationKey,
    required this.explanationKey,
    this.audioAsset,
  });
}
