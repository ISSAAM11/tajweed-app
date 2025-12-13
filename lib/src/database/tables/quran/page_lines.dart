import 'package:drift/drift.dart';

@DataClassName('PageLineRow')
class PageLines extends Table {
  IntColumn get pageNumber => integer().named('page_number')();
  IntColumn get lineNumber => integer().named('line_number')();
  TextColumn get lineType => text().named('line_type')();
  BoolColumn get isCentered => boolean().named('is_centered')();
  IntColumn get firstWordId => integer().named('first_word_id').nullable()();
  IntColumn get lastWordId => integer().named('last_word_id').nullable()();
  IntColumn get surahNumber => integer().named('surah_number').nullable()();

  @override
  Set<Column> get primaryKey => {pageNumber, lineNumber};
}
