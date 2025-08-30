import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart'
    show HizbFractionConverter, BoolIntConverter;

@DataClassName("AyahMetaRow")
class AyahMetas extends Table {
  IntColumn get globalIndex =>
      integer().named('global_index')(); // 1..6236 unique index

  IntColumn get surah => integer().named('surah')(); // Surah number (1..114)
  IntColumn get ayah => integer().named('ayah')(); // Local ayah number in surah
  IntColumn get pageNo => integer().named('page_no')();
  IntColumn get juzNo => integer().named('juz_no')();
  IntColumn get hizbNo => integer().named('hizb_no')();
  IntColumn get rukuNo => integer().named('ruku_no')();
  IntColumn get hizbFraction =>
      integer().named('hizb_fraction').map(const HizbFractionConverter())();
  IntColumn get hasSajdah =>
      integer().named('has_sajdah').map(const BoolIntConverter())();

  @override
  Set<Column> get primaryKey => {globalIndex};
}
