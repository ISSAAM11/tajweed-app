import 'package:drift/drift.dart';

@DataClassName('Hizb')
class Hizbs extends Table {
  IntColumn get hizbNumber => integer()();
  IntColumn get versesCount => integer().nullable()();
  TextColumn get firstVerseKey => text().nullable()();
  TextColumn get lastVerseKey => text().nullable()();
  TextColumn get verseMapping => text().nullable()();

  @override
  Set<Column> get primaryKey => {hizbNumber};
}
