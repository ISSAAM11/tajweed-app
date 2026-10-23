import 'package:drift/drift.dart';

class CheikhListTable extends Table {
  @override
  String get tableName => 'cheikh_list';

  TextColumn get id          => text()();
  TextColumn get nameArabic  => text()();
  TextColumn get nameSimple  => text()();
  TextColumn get dbAssetPath => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
