part of '../recitation_test_bloc.dart';

sealed class RecitationTestEvent extends Equatable {
  const RecitationTestEvent();

  @override
  List<Object?> get props => [];
}

/// Load Al-Fatiha's words from the local prebuilt DB.
final class LoadWords extends RecitationTestEvent {
  const LoadWords();
}

/// User tapped "Start" — request mic, open socket, begin streaming.
final class StartSession extends RecitationTestEvent {
  const StartSession();
}

/// A raw PCM audio frame captured from the mic.
final class AudioChunkReady extends RecitationTestEvent {
  final List<int> chunk;
  const AudioChunkReady(this.chunk);

  @override
  List<Object?> get props => [chunk];
}

/// A verdict (or done/error) arrived from the backend.
final class VerdictReceived extends RecitationTestEvent {
  final RecitationServerMessage message;
  const VerdictReceived(this.message);

  @override
  List<Object?> get props => [message];
}

/// User tapped "Stop" — finalize the session.
final class StopSession extends RecitationTestEvent {
  const StopSession();
}

/// User tapped "Try Again" — clear verdicts, back to neutral.
final class Reset extends RecitationTestEvent {
  const Reset();
}

/// Internal: the mic stream or socket failed mid-session.
final class _SessionFailed extends RecitationTestEvent {
  final String reasonKey;
  const _SessionFailed(this.reasonKey);

  @override
  List<Object?> get props => [reasonKey];
}
