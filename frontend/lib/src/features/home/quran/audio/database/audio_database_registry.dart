import 'dart:io';

import 'package:flutter/services.dart';
import 'package:generic_requester/generic_requester.dart' show Dio;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/audio_database.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';

/// Opens and caches one [AudioDatabase] per cheikh.
/// Uses Future caching to avoid double-open on concurrent calls.
/// Failed futures are evicted from the cache so the next call retries cleanly.
class AudioDatabaseRegistry {
  final Dio _dio;
  final Map<String, Future<AudioDatabase>> _opening = {};

  AudioDatabaseRegistry(this._dio);

  Future<AudioDatabase> forCheikh(CheikhReciter cheikh) {
    final existing = _opening[cheikh.id];
    if (existing != null) return existing;

    final future = _openForCheikh(cheikh);
    _opening[cheikh.id] = future;

    // Evict on failure so the next call retries from scratch.
    future.onError((error, _) {
      _opening.remove(cheikh.id);
      return Future.error(error!);
    });

    return future;
  }

  Future<AudioDatabase> _openForCheikh(CheikhReciter cheikh) async {
    final docDir = await getApplicationDocumentsDirectory();
    final file = File(p.join(docDir.path, 'quran_audio_db', '${cheikh.id}.db'));

    if (!await file.exists()) {
      await file.parent.create(recursive: true);
      await _fetchAtomically(cheikh.dbAssetPath, file);
    }

    // Verify the DB is not corrupt.  NativeDatabase is lazy, so we must run a
    // query to trigger the actual open.  On failure, delete and re-fetch.
    try {
      final db = AudioDatabase.fromFile(file);
      await db.customSelect('SELECT 1').get();
      return db;
    } catch (_) {
      try { await file.delete(); } catch (_) {}
      await _fetchAtomically(cheikh.dbAssetPath, file);
      return AudioDatabase.fromFile(file);
    }
  }

  /// Writes to a `.tmp` file first, then renames atomically.
  /// If the process is killed mid-write the final file stays clean.
  ///
  /// [source] is either a Flutter asset path (the bundled default reciter)
  /// or an http(s) URL — reciters synced from the backend catalog ship only
  /// their timing db as a download, never as an app asset.
  Future<void> _fetchAtomically(String source, File target) async {
    final tmp = File('${target.path}.tmp');
    if (source.startsWith('http')) {
      await _dio.download(source, tmp.path);
    } else {
      final data = await rootBundle.load(source);
      await tmp.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }
    await tmp.rename(target.path);
  }

  Future<void> dispose() async {
    final futures = _opening.values.toList();
    _opening.clear();
    for (final f in futures) {
      try {
        final db = await f;
        await db.close();
      } catch (_) {
        // Already failed to open — nothing to close.
      }
    }
  }
}
