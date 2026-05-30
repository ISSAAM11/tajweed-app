import 'package:drift/drift.dart';

import 'converters.dart';

@DataClassName('RukuRow')
class Rukus extends Table {
  IntColumn get rukuNumber => integer().named('ruku_number')();
  IntColumn get surahRukuNumber => integer().named('surah_ruku_number')();
  IntColumn get versesCount => integer().named('verses_count')();
  TextColumn get firstVerseKey =>
      text().named('first_verse_key').map(const VerseKeyConverter())();
  TextColumn get lastVerseKey =>
      text().named('last_verse_key').map(const VerseKeyConverter())();
  TextColumn get verseMapping =>
      text().named('verse_mapping').map(const SurahRangesConverter())();

  @override
  Set<Column> get primaryKey => {rukuNumber};
}
