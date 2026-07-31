import 'package:drift/drift.dart';

class SegmentsTable extends Table {
  @override
  String get tableName => 'segments';

  IntColumn get surahNumber => integer()();
  IntColumn get ayahNumber => integer()();
  IntColumn get durationSec => integer()();
  IntColumn get timestampFrom => integer()();
  IntColumn get timestampTo => integer()();
  TextColumn get segments => text()();

  @override
  Set<Column> get primaryKey => {surahNumber, ayahNumber};
}
