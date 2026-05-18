import 'package:tajweed_ai/src/database/app_database.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

/// Base class for all items in the listing (surahs, pages, juzs, etc.)
abstract class PartitionItem {
  VerseKey get verseKey;
  List<String> get ayahWords;
}

/// Page item
class PageItem extends PartitionItem {
  final int pageNumber;
  final VerseKey _verseKey;
  final List<String> _ayahWords;

  PageItem({
    required this.pageNumber,
    required VerseKey verseKey,
    required List<String> ayahWords,
  }) : _verseKey = verseKey,
       _ayahWords = ayahWords;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  List<String> get ayahWords => _ayahWords;

  Map<String, dynamic> toMap() => {
    'pageNumber': pageNumber,
    'verseKey': _verseKey.toString(),
    'ayahWords': _ayahWords,
  };

  factory PageItem.fromMap(Map<String, dynamic> map) => PageItem(
    pageNumber: map['pageNumber'] as int,
    verseKey: VerseKey.parse(map['verseKey'] as String),
    ayahWords: List<String>.from(map['ayahWords'] as List),
  );
}

/// Juz item
class JuzItem extends PartitionItem {
  final int juzNumber;
  final int pageNumber;
  final VerseKey _verseKey;
  final List<String> _ayahWords;

  JuzItem({
    required this.juzNumber,
    required this.pageNumber,
    required VerseKey verseKey,
    required List<String> ayahWords,
  }) : _verseKey = verseKey,
       _ayahWords = ayahWords;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  List<String> get ayahWords => _ayahWords;

  Map<String, dynamic> toMap() => {
    'juzNumber': juzNumber,
    'pageNumber': pageNumber,
    'verseKey': _verseKey.toString(),
    'ayahWords': _ayahWords,
  };

  factory JuzItem.fromMap(Map<String, dynamic> map) => JuzItem(
    juzNumber: map['juzNumber'] as int,
    pageNumber: map['pageNumber'] as int,
    verseKey: VerseKey.parse(map['verseKey'] as String),
    ayahWords: List<String>.from(map['ayahWords'] as List),
  );
}

/// Hizb item
class HizbItem extends PartitionItem {
  final int juzNumber;
  final int pageNumber;
  final HizbFraction fraction;
  final VerseKey _verseKey;
  final List<String> _ayahWords;

  HizbItem({
    required this.juzNumber,
    required this.pageNumber,
    required this.fraction,
    required VerseKey verseKey,
    required List<String> ayahWords,
  }) : _verseKey = verseKey,
       _ayahWords = ayahWords;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  List<String> get ayahWords => _ayahWords;

  Map<String, dynamic> toMap() => {
    'juzNumber': juzNumber,
    'pageNumber': pageNumber,
    'fraction': fraction.index,
    'verseKey': _verseKey.toString(),
    'ayahWords': _ayahWords,
  };

  factory HizbItem.fromMap(Map<String, dynamic> map) => HizbItem(
    juzNumber: map['juzNumber'] as int,
    pageNumber: map['pageNumber'] as int,
    fraction: HizbFraction.values[map['fraction'] as int],
    verseKey: VerseKey.parse(map['verseKey'] as String),
    ayahWords: List<String>.from(map['ayahWords'] as List),
  );
}

/// Ruku item
class RukuItem extends PartitionItem {
  final int rukuNumber;
  final int pageNumber;
  final VerseKey _verseKey;
  final List<String> _ayahWords;

  RukuItem({
    required this.rukuNumber,
    required this.pageNumber,
    required VerseKey verseKey,
    required List<String> ayahWords,
  }) : _verseKey = verseKey,
       _ayahWords = ayahWords;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  List<String> get ayahWords => _ayahWords;

  Map<String, dynamic> toMap() => {
    'rukuNumber': rukuNumber,
    'pageNumber': pageNumber,
    'verseKey': _verseKey.toString(),
    'ayahWords': _ayahWords,
  };

  factory RukuItem.fromMap(Map<String, dynamic> map) => RukuItem(
    rukuNumber: map['rukuNumber'] as int,
    pageNumber: map['pageNumber'] as int,
    verseKey: VerseKey.parse(map['verseKey'] as String),
    ayahWords: List<String>.from(map['ayahWords'] as List),
  );
}

/// Last Selected Page item
class LastSelectedPage extends PartitionItem {
  String name;
  String nameArabic;
  int pageNumber;
  final VerseKey _verseKey;

  LastSelectedPage({
    required this.name,
    required this.nameArabic,
    required this.pageNumber,
    required VerseKey verseKey,
  }) : _verseKey = verseKey;

  @override
  VerseKey get verseKey => _verseKey;

  @override
  List<String> get ayahWords => throw UnimplementedError();

  Map<String, dynamic> toMap() => {
    'name': name,
    'nameArabic': nameArabic,
    'pageNumber': pageNumber,
    'verseKey': _verseKey.toString(),
  };

  factory LastSelectedPage.fromMap(Map<String, dynamic> map) =>
      LastSelectedPage(
        name: map['name'] as String,
        nameArabic: map['nameArabic'] as String,
        pageNumber: map['pageNumber'] as int,
        verseKey: VerseKey.parse(map['verseKey'] as String),
      );
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
  final List<String> _ayahWords;

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
    required List<String> ayahWords,
  }) : _verseKey = verseKey,
       _ayahWords = ayahWords;

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
      _ayahWords = [];

  @override
  VerseKey get verseKey => _verseKey;

  @override
  List<String> get ayahWords => _ayahWords;

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'nameSimple': nameSimple,
    'nameArabic': nameArabic,
    'revelationOrder': revelationOrder,
    'revelationPlace': revelationPlace.name,
    'versesCount': versesCount,
    'bismillahPre': bismillahPre,
    'nameGlyph': nameGlyph,
    'verseKey': _verseKey.toString(),
    'ayahWords': _ayahWords,
  };

  factory ChapterItem.fromMap(Map<String, dynamic> map) => ChapterItem(
    id: map['id'] as int,
    name: map['name'] as String,
    nameSimple: map['nameSimple'] as String,
    nameArabic: map['nameArabic'] as String,
    revelationOrder: map['revelationOrder'] as int,
    revelationPlace: (map['revelationPlace'] == 'makkah'
        ? RevelationPlace.makkah
        : RevelationPlace.madinah),
    versesCount: map['versesCount'] as int,
    bismillahPre: map['bismillahPre'] as bool,
    nameGlyph: map['nameGlyph'] as String,
    verseKey: VerseKey.parse(map['verseKey'] as String),
    ayahWords: List<String>.from(map['ayahWords'] ?? []),
  );
}
