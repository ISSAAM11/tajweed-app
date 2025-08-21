import 'package:drift/drift.dart';

import 'converters.dart';

@DataClassName('HizbRow')
class Hizbs extends Table {
  // DB table is already plural "hizbs"
  IntColumn get hizbNumber => integer().named('hizb_number')();
  IntColumn get versesCount => integer().named('verses_count')();

  TextColumn get firstVerseKey =>
      text().named('first_verse_key').map(const VerseKeyConverter())();

  TextColumn get lastVerseKey =>
      text().named('last_verse_key').map(const VerseKeyConverter())();

  TextColumn get verseMapping =>
      text().named('verse_mapping').map(const SurahRangesConverter())();

  @override
  Set<Column> get primaryKey => {hizbNumber};
}
