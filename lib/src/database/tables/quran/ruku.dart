import 'package:drift/drift.dart';

@DataClassName('Ruku')
class Rukus extends Table {
  IntColumn get rukuNumber => integer().named('ruku_number')();
  IntColumn get surahRukuNumber => integer().named('surah_ruku_number')();
  IntColumn get versesCount => integer().named('verses_count')();
  TextColumn get firstVerseKey => text().named('first_verse_key')();
  TextColumn get lastVerseKey => text().named('last_verse_key')();
  TextColumn get verseMapping => text().named('verse_mapping')();

  @override
  Set<Column> get primaryKey => {rukuNumber};
}
