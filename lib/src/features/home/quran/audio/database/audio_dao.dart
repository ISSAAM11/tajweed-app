import 'package:drift/drift.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/audio_database_registry.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/ayah_segment.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';

class AudioDao {
  final AudioDatabaseRegistry _registry;
  AudioDao(this._registry);

  // ── Surah-level methods (Al-Nufais style: surah_list + segments tables) ──

  Future<String?> getSurahAudioUrl(CheikhReciter cheikh, int surah) async {
    if (cheikh.audioType != CheikhAudioType.surahLevel) return null;
    final db = await _registry.forCheikh(cheikh);
    final query = db.select(db.surahListTable)
      ..where((t) => t.surahNumber.equals(surah));
    final row = await query.getSingleOrNull();
    return row?.audioUrl;
  }

  Future<AyahSegment?> getAyahSegment(
    CheikhReciter cheikh,
    int surah,
    int ayah,
  ) async {
    final db = await _registry.forCheikh(cheikh);

    if (cheikh.audioType == CheikhAudioType.ayahLevel) {
      final result = await db.customSelect(
        'SELECT ayah_number FROM verses WHERE surah_number = ? AND ayah_number = ?',
        variables: [Variable.withInt(surah), Variable.withInt(ayah)],
      ).getSingleOrNull();
      if (result == null) return null;
      return AyahSegment(
        surah: surah,
        ayah: result.read<int>('ayah_number'),
        timestampFrom: 0,
        timestampTo: 0,
        fullFile: true,
      );
    }

    final query = db.select(db.segmentsTable)
      ..where(
        (t) => t.surahNumber.equals(surah) & t.ayahNumber.equals(ayah),
      );
    final row = await query.getSingleOrNull();
    if (row == null) return null;
    return AyahSegment(
      surah: row.surahNumber,
      ayah: row.ayahNumber,
      timestampFrom: row.timestampFrom,
      timestampTo: row.timestampTo,
    );
  }

  Future<List<AyahSegment>> getSurahSegments(
    CheikhReciter cheikh,
    int surah,
  ) async {
    final db = await _registry.forCheikh(cheikh);

    if (cheikh.audioType == CheikhAudioType.ayahLevel) {
      final rows = await db.customSelect(
        'SELECT ayah_number FROM verses WHERE surah_number = ? ORDER BY ayah_number',
        variables: [Variable.withInt(surah)],
      ).get();
      return rows
          .map(
            (r) => AyahSegment(
              surah: surah,
              ayah: r.read<int>('ayah_number'),
              timestampFrom: 0,
              timestampTo: 0,
              fullFile: true,
            ),
          )
          .toList();
    }

    final query = db.select(db.segmentsTable)
      ..where((t) => t.surahNumber.equals(surah))
      ..orderBy([(t) => OrderingTerm.asc(t.ayahNumber)]);
    final rows = await query.get();
    return rows
        .map(
          (r) => AyahSegment(
            surah: r.surahNumber,
            ayah: r.ayahNumber,
            timestampFrom: r.timestampFrom,
            timestampTo: r.timestampTo,
          ),
        )
        .toList();
  }

  Future<List<AyahSegment>> getAyahsSegments(
    CheikhReciter cheikh,
    List<VerseKey> ayahs,
  ) async {
    if (ayahs.isEmpty) return [];
    final db = await _registry.forCheikh(cheikh);

    if (cheikh.audioType == CheikhAudioType.ayahLevel) {
      final results = <AyahSegment>[];
      for (final key in ayahs) {
        final row = await db.customSelect(
          'SELECT ayah_number FROM verses WHERE surah_number = ? AND ayah_number = ?',
          variables: [Variable.withInt(key.surah), Variable.withInt(key.ayah)],
        ).getSingleOrNull();
        if (row != null) {
          results.add(AyahSegment(
            surah: key.surah,
            ayah: row.read<int>('ayah_number'),
            timestampFrom: 0,
            timestampTo: 0,
            fullFile: true,
          ));
        }
      }
      return results;
    }

    final Map<int, List<int>> bySurah = {};
    for (final v in ayahs) {
      bySurah.putIfAbsent(v.surah, () => []).add(v.ayah);
    }

    final results = <AyahSegment>[];
    for (final entry in bySurah.entries) {
      final surah = entry.key;
      final ayahNums = entry.value;
      final query = db.select(db.segmentsTable)
        ..where(
          (t) =>
              t.surahNumber.equals(surah) &
              t.ayahNumber.isIn(ayahNums),
        )
        ..orderBy([(t) => OrderingTerm.asc(t.ayahNumber)]);
      final rows = await query.get();
      results.addAll(
        rows.map(
          (r) => AyahSegment(
            surah: r.surahNumber,
            ayah: r.ayahNumber,
            timestampFrom: r.timestampFrom,
            timestampTo: r.timestampTo,
          ),
        ),
      );
    }

    final keyIndex = {for (int i = 0; i < ayahs.length; i++) ayahs[i]: i};
    results.sort((a, b) {
      final ka = VerseKey(a.surah, a.ayah);
      final kb = VerseKey(b.surah, b.ayah);
      return (keyIndex[ka] ?? 0).compareTo(keyIndex[kb] ?? 0);
    });

    return results;
  }

  // ── Ayah-level method (As-Sudais style: verses table) ────────────────────

  /// Returns (ayahNumber, audioUrl) pairs for all ayahs in [surah].
  /// Only valid for [CheikhAudioType.ayahLevel] cheikhs.
  Future<List<({int ayah, String url})>> getAyahAudioUrlsForSurah(
    CheikhReciter cheikh,
    int surah,
  ) async {
    final db = await _registry.forCheikh(cheikh);
    final rows = await db.customSelect(
      'SELECT ayah_number, audio_url FROM verses WHERE surah_number = ? ORDER BY ayah_number',
      variables: [Variable.withInt(surah)],
    ).get();
    return rows
        .map((r) => (ayah: r.read<int>('ayah_number'), url: r.read<String>('audio_url')))
        .toList();
  }
}
