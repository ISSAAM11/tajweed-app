import 'dart:io';

import 'package:cg_core_defs/cg_core_defs.dart';
import 'package:generic_requester/generic_requester.dart' show Dio;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';

class AudioDownloadService {
  final Dio _dio;
  final ConnectivityMonitor _connectivity;

  AudioDownloadService(this._dio, this._connectivity);

  // ── Path helpers ──────────────────────────────────────────────────────────

  Future<File> _resolveFile(CheikhReciter cheikh, int surah) async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, 'quran_audio', cheikh.id, '$surah.mp3'));
  }

  Future<File> _resolveAyahFile(CheikhReciter cheikh, int surah, int ayah) async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, 'quran_audio', cheikh.id, '$surah', '$ayah.mp3'));
  }

  Future<File> _resolveAyahMarker(CheikhReciter cheikh, int surah) async {
    final dir = await getApplicationDocumentsDirectory();
    return File(p.join(dir.path, 'quran_audio', cheikh.id, '$surah', '_done'));
  }

  // ── Public API ────────────────────────────────────────────────────────────

  Future<bool> isSurahDownloaded(CheikhReciter cheikh, int surah) async {
    if (cheikh.audioType == CheikhAudioType.ayahLevel) {
      return (await _resolveAyahMarker(cheikh, surah)).exists();
    }
    return (await _resolveFile(cheikh, surah)).exists();
  }

  /// Returns the local file for a surah-level cheikh.
  Future<File> getLocalFile(CheikhReciter cheikh, int surah) =>
      _resolveFile(cheikh, surah);

  /// Returns the local file for a single ayah (ayah-level cheikh).
  Future<File> getAyahFile(CheikhReciter cheikh, int surah, int ayah) =>
      _resolveAyahFile(cheikh, surah, ayah);

  /// Downloads a single surah MP3 (surah-level cheikhs).
  Future<File> downloadSurah(
    String audioUrl,
    CheikhReciter cheikh,
    int surah, {
    void Function(double progress)? onProgress,
  }) async {
    if (!_connectivity.isConnected) {
      throw const SocketException('No internet connection');
    }

    final file = await _resolveFile(cheikh, surah);
    await file.parent.create(recursive: true);

    final tempPath = '${file.path}.tmp';
    await _dio.download(
      audioUrl,
      tempPath,
      onReceiveProgress: (received, total) {
        if (total > 0 && onProgress != null) {
          onProgress(received / total);
        }
      },
    );

    await File(tempPath).rename(file.path);
    return file;
  }

  /// Downloads all ayah MP3s for a surah (ayah-level cheikhs).
  /// Writes a `_done` marker file when complete so [isSurahDownloaded] returns true.
  Future<void> downloadAyahs(
    List<({int ayah, String url})> ayahUrls,
    CheikhReciter cheikh,
    int surah, {
    void Function(double progress)? onProgress,
  }) async {
    if (!_connectivity.isConnected) {
      throw const SocketException('No internet connection');
    }

    final dir = await getApplicationDocumentsDirectory();
    final surahDir =
        Directory(p.join(dir.path, 'quran_audio', cheikh.id, '$surah'));
    await surahDir.create(recursive: true);

    final total = ayahUrls.length;
    for (int i = 0; i < total; i++) {
      final (:ayah, :url) = ayahUrls[i];
      final file = File(p.join(surahDir.path, '$ayah.mp3'));
      final tempPath = '${file.path}.tmp';

      await _dio.download(
        url,
        tempPath,
        onReceiveProgress: (received, fileTotal) {
          if (fileTotal > 0 && onProgress != null) {
            onProgress((i + received / fileTotal) / total);
          }
        },
      );

      await File(tempPath).rename(file.path);
      onProgress?.call((i + 1) / total);
    }

    // Mark surah as fully downloaded
    final marker = File(p.join(surahDir.path, '_done'));
    await marker.writeAsString('');
  }
}
