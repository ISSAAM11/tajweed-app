import 'package:drift/drift.dart';

@DataClassName('Chapter')
class Chapters extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get name => text().named('name')();
  TextColumn get nameSimple => text().named('name_simple')();
  TextColumn get nameArabic => text().named('name_arabic')();
  IntColumn get revelationOrder => integer().named('revelation_order')();
  TextColumn get revelationPlace => text().named('revelation_place')();
  IntColumn get versesCount => integer().named('verses_count')();
  IntColumn get bismillahPre => integer().named('bismillah_pre')();

  @override
  Set<Column> get primaryKey => {id};
}
