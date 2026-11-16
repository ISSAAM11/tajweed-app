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

  /// Position and length of the item playing right now. For a surah-level
  /// reciter the item is a [ClippingAudioSource], so both are already relative
  /// to the ayah's clip rather than to the whole-surah file.
  ///
  /// Deliberately not routed through [AudioPlayerBloc]: position ticks several
  /// times a second, and emitting a state that often would rebuild the whole
  /// ayah list. Widgets that want a progress indicator subscribe directly and
  /// keep the rebuild scoped to themselves.
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;

  /// Emits whenever `play()` throws — lets the bloc reset to idle.
  Stream<Object> get playerErrorStream => _errorController.stream;

  /// [filePaths] has one entry per segment in the same order.
  /// [loop] repeats the current item (a clipped segment for surah-level
  /// reciters, the whole file for ayah-level ones) until the next request.
  Future<void> playQueue(
    List<AyahSegment> segments,
    List<String> filePaths, {
    int startIndex = 0,
    bool loop = false,
  }) async {
    final sources = ConcatenatingAudioSource(
      children: [
        for (int i = 0; i < segments.length; i++)
          segments[i].toAudioSource(filePaths[i]),
      ],
    );
    await _player.setAudioSource(sources, initialIndex: startIndex);
    await _player.setLoopMode(loop ? LoopMode.one : LoopMode.off);
    _player.play().catchError((e) => _errorController.add(e));
  }

  Future<void> pause() => _player.pause();

  /// Deliberately not awaited: just_audio's `play()` future completes when
  /// playback *ends*, not when it starts. Awaiting it would stall the caller
  /// for the whole track — the bloc would never emit its playing state.
  Future<void> resume() async {
    unawaited(_player.play().catchError((e) => _errorController.add(e)));
  }

  Future<void> stop() => _player.stop();
  Future<void> skipNext() => _player.seekToNext();
  Future<void> skipPrevious() => _player.seekToPrevious();

  Future<void> dispose() async {
    await _errorController.close();
    await _player.dispose();
  }
}
