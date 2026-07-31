import 'dart:async';

import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/ayah_segment.dart';

class QuranAudioPlayerService {
  final AudioPlayer _player = AudioPlayer();
  final _errorController = StreamController<Object>.broadcast();

  QuranAudioPlayerService() {
    _initAudioSession();
  }

  Future<void> _initAudioSession() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
  }

  Stream<int?> get currentIndexStream => _player.currentIndexStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  /// Emits whenever `play()` throws — lets the bloc reset to idle.
  Stream<Object> get playerErrorStream => _errorController.stream;

  /// [filePaths] has one entry per segment in the same order.
  Future<void> playQueue(
    List<AyahSegment> segments,
    List<String> filePaths, {
    int startIndex = 0,
  }) async {
    final sources = ConcatenatingAudioSource(
      children: [
        for (int i = 0; i < segments.length; i++)
          segments[i].toAudioSource(filePaths[i]),
      ],
    );
    await _player.setAudioSource(sources, initialIndex: startIndex);
    _player.play().catchError((e) => _errorController.add(e));
  }

  Future<void> pause() => _player.pause();

  void resume() {
    _player.play().catchError((e) => _errorController.add(e));
  }

  Future<void> stop() => _player.stop();
  Future<void> skipNext() => _player.seekToNext();
  Future<void> skipPrevious() => _player.seekToPrevious();

  Future<void> dispose() async {
    await _errorController.close();
    await _player.dispose();
  }
}
