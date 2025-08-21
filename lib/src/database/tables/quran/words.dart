import 'package:drift/drift.dart';

import 'converters.dart';

@DataClassName('WordRow')
class Words extends Table {
  IntColumn get id => integer().named('id')();
  TextColumn get location =>
      text().named('location').map(const WordLocationConverter())();
  IntColumn get surah => integer().named('surah')();
  IntColumn get ayah => integer().named('ayah')();
  IntColumn get word => integer().named('word')();
  TextColumn get text_ => text().named('text')();

  @override
  Set<Column> get primaryKey => {id};
}
