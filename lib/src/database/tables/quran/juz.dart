import 'package:drift/drift.dart';

@DataClassName('Juz')
class Juzs extends Table {
  IntColumn get juzNumber => integer().named('juz_number')();
  IntColumn get versesCount => integer().named('verses_count')();
  TextColumn get firstVerseKey => text().named('first_verse_key')();
  TextColumn get lastVerseKey => text().named('last_verse_key')();
  TextColumn get verseMapping => text().named('verse_mapping')();

  @override
  Set<Column> get primaryKey => {juzNumber};
}
