part of 'audio_player_bloc.dart';

enum PlaybackMode { single, page, surah }

sealed class AudioPlayerState extends Equatable {
  const AudioPlayerState();
  @override
  List<Object?> get props => [];
}

class AudioIdle extends AudioPlayerState {
  const AudioIdle();
}

class AudioAwaitingDownload extends AudioPlayerState {
  final PendingRequest pending;
  const AudioAwaitingDownload(this.pending);
  @override
  List<Object?> get props => [pending];
}

class AudioDownloading extends AudioPlayerState {
  final double progress;
  const AudioDownloading(this.progress);
  @override
  List<Object?> get props => [progress];
}

class AudioPlaying extends AudioPlayerState {
  final int surah;
  final int currentAyah;
  final PlaybackMode mode;
  final int currentIndex;
  final int totalInQueue;
  final bool looping;

  const AudioPlaying({
    required this.surah,
    required this.currentAyah,
    required this.mode,
    required this.currentIndex,
    required this.totalInQueue,
    this.looping = false,
  });

  AudioPlaying copyWithIndex(int newIndex, List<AyahSegment> queue) {
    final segment = queue[newIndex];
    return AudioPlaying(
      surah: segment.surah,
      currentAyah: segment.ayah,
      mode: mode,
      currentIndex: newIndex,
      totalInQueue: totalInQueue,
      looping: looping,
    );
  }

  @override
  List<Object?> get props =>
      [surah, currentAyah, mode, currentIndex, totalInQueue, looping];
}

class AudioPaused extends AudioPlayerState {
  final int surah;
  final int currentAyah;
  final PlaybackMode mode;
  final int currentIndex;
  final int totalInQueue;
  final bool looping;

  const AudioPaused({
    required this.surah,
    required this.currentAyah,
    required this.mode,
    required this.currentIndex,
    required this.totalInQueue,
    this.looping = false,
  });

  @override
  List<Object?> get props =>
      [surah, currentAyah, mode, currentIndex, totalInQueue, looping];
}

class AudioError extends AudioPlayerState {
  final String messageKey;
  const AudioError(this.messageKey);
  @override
  List<Object?> get props => [messageKey];
}

// Internal pending request stored while awaiting download confirmation
class PendingRequest extends Equatable {
  final int surah;
  final int ayah;
  final PlaybackMode mode;
  final List<VerseKey>? pageAyahs;
  final bool loop;

  const PendingRequest({
    required this.surah,
    required this.ayah,
    required this.mode,
    this.pageAyahs,
    this.loop = false,
  });

  @override
  List<Object?> get props => [surah, ayah, mode, pageAyahs, loop];
}
