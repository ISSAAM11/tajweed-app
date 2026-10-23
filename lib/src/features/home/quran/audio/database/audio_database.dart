import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/tables/segments_table.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/tables/surah_list_table.dart';

part 'audio_database.g.dart';

const _kCheikhDbAssetPath = 'assets/db/surah-recitation-ahmad-alnufais.db';
const _kCheikhDbLocalName = 'audio-ahmad-alnufais.db';

@DriftDatabase(tables: [SegmentsTable, SurahListTable])
class AudioDatabase extends _$AudioDatabase {
  AudioDatabase() : super(_openAudioConnection());

  AudioDatabase.fromFile(File dbFile)
      : super(NativeDatabase.createInBackground(dbFile));

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openAudioConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, _kCheikhDbLocalName);
    final file = File(dbPath);

    if (!await file.exists()) {
      final data = await rootBundle.load(_kCheikhDbAssetPath);
      final bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );
      await file.writeAsBytes(bytes, flush: true);
    }

    return NativeDatabase.createInBackground(file);
  });
}
