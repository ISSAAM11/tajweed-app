import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

enum PartitionMode { surah, page, juz, hizb, ruku }

class PageRange {
  final int startPage;
  final int endPage;
  const PageRange(this.startPage, this.endPage);
}

class PartitionMeta {
  final int partitionId; // juzNumber, hizbNumber, etc.
  final PartitionMode mode;
  final PageRange pageRange;
  final VerseKey firstVerse;
  final VerseKey lastVerse;
  PartitionMeta({
    required this.partitionId,
    required this.mode,
    required this.pageRange,
    required this.firstVerse,
    required this.lastVerse,
  });
}

class IndicatorMeta {
  final int pageNo;
  final int surah;
  final int juz;
  final int hizb;
  final int ruku;
  final HizbFraction hizbFraction;

  IndicatorMeta({
    required this.pageNo,
    required this.surah,
    required this.juz,
    required this.hizb,
    required this.ruku,
    required this.hizbFraction,
  });
}

class PageMeta {
  final int pageNo;
  final IndicatorMeta indicator;
  PageMeta({required this.pageNo, required this.indicator});
}
