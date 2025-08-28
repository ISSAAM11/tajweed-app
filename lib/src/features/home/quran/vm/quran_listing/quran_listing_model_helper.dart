import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_events.dart';

/// Base class for all items in the listing (surahs, pages, juzs, etc.)
abstract class PartitionItem {
  VerseKey get verseKey;
  String get ayahText;
}

/// Page item
class PageItem extends PartitionItem {
  final int pageNumber;
  final VerseKey _verseKey;
  final String _ayahText;

  PageItem({
    required this.pageNumber,
    required VerseKey verseKey,
    required String ayahText,
  }) : _verseKey = verseKey,
       _ayahText = ayahText;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  String get ayahText => _ayahText;
}

/// Juz item
class JuzItem extends PartitionItem {
  final int juzNumber;
  final VerseKey _verseKey;
  final String _ayahText;

  JuzItem({
    required this.juzNumber,
    required VerseKey verseKey,
    required String ayahText,
  }) : _verseKey = verseKey,
       _ayahText = ayahText;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  String get ayahText => _ayahText;
}

/// Hizb item
class HizbItem extends PartitionItem {
  final int juzNumber;
  final HizbFraction fraction;
  final VerseKey _verseKey;
  final String _ayahText;

  HizbItem({
    required this.juzNumber,
    required this.fraction,
    required VerseKey verseKey,
    required String ayahText,
  }) : _verseKey = verseKey,
       _ayahText = ayahText;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  String get ayahText => _ayahText;
}

/// Ruku item
class RukuItem extends PartitionItem {
  final int rukuNumber;
  final VerseKey _verseKey;
  final String _ayahText;

  RukuItem({
    required this.rukuNumber,
    required VerseKey verseKey,
    required String ayahText,
  }) : _verseKey = verseKey,
       _ayahText = ayahText;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  String get ayahText => _ayahText;
}

/// Chapter item
class ChapterItem extends PartitionItem {
  int id;
  String name;
  String nameSimple;
  String nameArabic;
  int revelationOrder;
  RevelationPlace revelationPlace;
  int versesCount;
  bool bismillahPre;
  String nameGlyph;

  final VerseKey _verseKey;
  final String _ayahText;

  ChapterItem({
    required this.id,
    required this.name,
    required this.nameSimple,
    required this.nameArabic,
    required this.revelationOrder,
    required this.revelationPlace,
    required this.versesCount,
    required this.bismillahPre,
    required this.nameGlyph,
    required VerseKey verseKey,
    required String ayahText,
  }) : _verseKey = verseKey,
       _ayahText = ayahText;

  ChapterItem.fromChapterRow(ChapterRow another)
    : id = another.id,
      name = another.name,
      nameSimple = another.nameSimple,
      nameArabic = another.nameArabic,
      _verseKey = VerseKey(another.id, 1),
      bismillahPre = another.bismillahPre,
      nameGlyph = another.nameGlyph,
      revelationOrder = another.revelationOrder,
      revelationPlace = another.revelationPlace,
      versesCount = another.versesCount,

      _ayahText = '';

  @override
  VerseKey get verseKey => _verseKey;

  @override
  String get ayahText => _ayahText;
}

/// Centralized helper to convert PartitionItems into domain actions/events
/// and provide labels for display.
final class PartitionHelper {
  /// Convert a [PartitionItem] into an [SelectPartitionEvent] event.
  static SelectPartitionEvent toSelectPartitionEvent(
    PartitionItem item,
    PartitionMode mode,
  ) {
    switch (mode) {
      case PartitionMode.surah:
        final c = item as ChapterItem;
        return SelectPartitionEvent(partitionId: c.id, mode: mode);

      case PartitionMode.page:
        final p = item as PageItem;
        return SelectPartitionEvent(partitionId: p.pageNumber, mode: mode);

      case PartitionMode.juz:
        final j = item as JuzItem;
        return SelectPartitionEvent(partitionId: j.juzNumber, mode: mode);

      case PartitionMode.hizb:
        final h = item as HizbItem;
        return SelectPartitionEvent(
          partitionId: h.juzNumber,
          mode: mode,
          fraction: h.fraction,
        );

      case PartitionMode.ruku:
        final r = item as RukuItem;
        return SelectPartitionEvent(partitionId: r.rukuNumber, mode: mode);
    }
  }

  /// Provide a human-readable title for UI cards
  static String titleForItem(PartitionItem item, PartitionMode mode) {
    switch (mode) {
      case PartitionMode.surah:
        final c = item as ChapterItem;
        return "Surah ${c.name}  ${c.name}";
      case PartitionMode.page:
        final p = item as PageItem;
        return "Page ${p.pageNumber}";
      case PartitionMode.juz:
        final j = item as JuzItem;
        return "Juz ${j.juzNumber}";
      case PartitionMode.hizb:
        final h = item as HizbItem;
        return "Hizb ${h.juzNumber}  ${hizbFractionValues[h.fraction]}";
      case PartitionMode.ruku:
        final r = item as RukuItem;
        return "Ruku ${r.rukuNumber}";
    }
  }
}
