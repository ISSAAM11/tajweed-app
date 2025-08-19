import 'package:drift/drift.dart';

@DataClassName('Sajdah')
class Sajdahs extends Table {
  IntColumn get sajdahNumber => integer().named('sajdah_number')();
  TextColumn get verseKey => text().named('verse_key')();
  TextColumn get sajdahType => text().named('sajdah_type')();

  @override
  Set<Column> get primaryKey => {sajdahNumber};
}
