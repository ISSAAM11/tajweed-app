part of '../quran_recitation_bloc.dart';

sealed class QuranRecitationEvent extends Equatable {
  const QuranRecitationEvent();

  @override
  List<Object?> get props => [];
}

/// Turn recitation mode on — reveals the control bar (no recording yet).
final class EnterRecitationMode extends QuranRecitationEvent {
  const EnterRecitationMode();
}

/// Turn recitation mode off — stop recording, clear coloring, hide the bar.
final class ExitRecitationMode extends QuranRecitationEvent {
  const ExitRecitationMode();
}

/// Toggle the memorization "hide text" aid.
final class ToggleHideText extends QuranRecitationEvent {
  const ToggleHideText();
}

/// Recite the given ordered words of [pageNo] (page-scoped flow: control bar +
/// FAB). Resets any current session and starts recording.
final class StartPageRecitation extends QuranRecitationEvent {
  final int pageNo;
  final List<({int id, String text})> words;
  const StartPageRecitation({required this.pageNo, required this.words});

  @override
  List<Object?> get props => [pageNo, words];
}

/// Recite [surah] from [startAyah] to its end (the kept ayah-popup flow).
final class StartRecitation extends QuranRecitationEvent {
  final int surah;
  final int startAyah;
  const StartRecitation(this.surah, this.startAyah);

  @override
  List<Object?> get props => [surah, startAyah];
}

/// Replay the current session from its first word (clears verdicts).
final class RestartRecitation extends QuranRecitationEvent {
  const RestartRecitation();
}

/// Stop the mic but keep mode + verdicts on screen (trailing finals still
/// arrive).
final class StopRecording extends QuranRecitationEvent {
  const StopRecording();
}

/// The visible page changed while in recitation mode — reset the session for
/// the new page (recording off until the user starts again).
final class RecitationPageChanged extends QuranRecitationEvent {
  final int pageNo;
  const RecitationPageChanged(this.pageNo);

  @override
  List<Object?> get props => [pageNo];
}

/// A raw PCM audio frame captured from the mic.
final class AudioChunkReady extends QuranRecitationEvent {
  final List<int> chunk;
  const AudioChunkReady(this.chunk);

  @override
  List<Object?> get props => [chunk];
}

/// A verdict (or done/error) arrived from the backend.
final class VerdictReceived extends QuranRecitationEvent {
  final RecitationServerMessage message;
  const VerdictReceived(this.message);

  @override
  List<Object?> get props => [message];
}

/// The mic stream or socket failed mid-session.
final class RecitationFailed extends QuranRecitationEvent {
  final String reasonKey;
  const RecitationFailed(this.reasonKey);

  @override
  List<Object?> get props => [reasonKey];
}
