part of 'audio_player_bloc.dart';

sealed class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();
  @override
  List<Object?> get props => [];
}

class RequestPlayAyah extends AudioPlayerEvent {
  final int surah;
  final int ayah;
  const RequestPlayAyah(this.surah, this.ayah);
  @override
  List<Object?> get props => [surah, ayah];
}

class RequestPlayPage extends AudioPlayerEvent {
  final List<VerseKey> ayahs;
  const RequestPlayPage(this.ayahs);
  @override
  List<Object?> get props => [ayahs];
}

class RequestPlaySurah extends AudioPlayerEvent {
  final int surah;
  final int startFromAyah;
  const RequestPlaySurah(this.surah, this.startFromAyah);
  @override
  List<Object?> get props => [surah, startFromAyah];
}

class ConfirmDownload extends AudioPlayerEvent {
  const ConfirmDownload();
}

class CancelDownload extends AudioPlayerEvent {
  const CancelDownload();
}

class PauseAudio extends AudioPlayerEvent {
  const PauseAudio();
}

class ResumeAudio extends AudioPlayerEvent {
  const ResumeAudio();
}

class StopAudio extends AudioPlayerEvent {
  const StopAudio();
}

class SkipNext extends AudioPlayerEvent {
  const SkipNext();
}

class SkipPrevious extends AudioPlayerEvent {
  const SkipPrevious();
}

class _IndexAdvanced extends AudioPlayerEvent {
  final int newIndex;
  final List<AyahSegment> queue;
  const _IndexAdvanced(this.newIndex, this.queue);
  @override
  List<Object?> get props => [newIndex];
}

class _PlaybackCompleted extends AudioPlayerEvent {
  const _PlaybackCompleted();
}

class _PlaybackError extends AudioPlayerEvent {
  const _PlaybackError();
}
