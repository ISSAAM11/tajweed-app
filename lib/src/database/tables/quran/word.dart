import 'package:drift/drift.dart';

@DataClassName('Word')
class Words extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get location => text().named('location')();
  IntColumn get surah => integer().named('surah')();
  IntColumn get ayah => integer().named('ayah')();
  IntColumn get word => integer().named('word')();
  TextColumn get textContent => text().named('text')();

  @override
  Set<Column> get primaryKey => {id};
}
