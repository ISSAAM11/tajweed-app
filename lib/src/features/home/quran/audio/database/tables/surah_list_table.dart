import 'package:drift/drift.dart';

class SurahListTable extends Table {
  @override
  String get tableName => 'surah_list';

  IntColumn get surahNumber => integer()();
  TextColumn get audioUrl => text()();
  IntColumn get duration => integer()();

  @override
  Set<Column> get primaryKey => {surahNumber};
}
