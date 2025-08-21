import 'package:drift/drift.dart';

import 'converters.dart';

@DataClassName('JuzRow')
class Juzs extends Table {
  IntColumn get juzNumber => integer().named('juz_number')();
  IntColumn get versesCount => integer().named('verses_count')();

  // Stored as "s:a", mapped to VerseKey
  TextColumn get firstVerseKey =>
      text().named('first_verse_key').map(const VerseKeyConverter())();

  TextColumn get lastVerseKey =>
      text().named('last_verse_key').map(const VerseKeyConverter())();

  // JSON like {"1":"1-7","2":"1-141"} -> SurahRanges
  TextColumn get verseMapping =>
      text().named('verse_mapping').map(const SurahRangesConverter())();

  @override
  Set<Column> get primaryKey => {juzNumber};
}
