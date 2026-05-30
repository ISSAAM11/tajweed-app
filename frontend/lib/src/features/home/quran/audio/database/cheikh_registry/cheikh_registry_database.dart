import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/cheikh_registry/tables/cheikh_list_table.dart';

part 'cheikh_registry_database.g.dart';

@DriftDatabase(tables: [CheikhListTable])
class CheikhRegistryDatabase extends _$CheikhRegistryDatabase {
  CheikhRegistryDatabase(File dbFile) : super(NativeDatabase(dbFile));

  @override
  int get schemaVersion => 1;
}
