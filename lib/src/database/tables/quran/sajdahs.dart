import 'package:drift/drift.dart';

import 'converters.dart';

@DataClassName('SajdahRow')
class Sajdahs extends Table {
  IntColumn get sajdahNumber => integer().named('sajdah_number')();
  TextColumn get verseKey =>
      text().named('verse_key').map(const VerseKeyConverter())();
  TextColumn get sajdahType =>
      text().named('sajdah_type').map(const SajdahTypeConverter())();

  @override
  Set<Column> get primaryKey => {sajdahNumber};
}
