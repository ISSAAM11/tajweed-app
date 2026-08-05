part of 'tajweed_test_bloc.dart';

sealed class TajweedTestState extends Equatable {
  /// Index of the current test in [tajweedTestItems].
  final int index;
  const TajweedTestState(this.index);

  TajweedTestItem get item => tajweedTestItems[index];
  int get total => tajweedTestItems.length;

  @override
  List<Object?> get props => [index];
}

/// Waiting for the user to start recording.
class TajweedTestReady extends TajweedTestState {
  const TajweedTestReady(super.index);
}

/// Microphone is live.
class TajweedTestRecording extends TajweedTestState {
  const TajweedTestRecording(super.index);
}

/// Audio sent, waiting for the transcription.
class TajweedTestEvaluating extends TajweedTestState {
  const TajweedTestEvaluating(super.index);
}

class TajweedTestResult extends TajweedTestState {
  /// Similarity ratio in [0, 1].
  final double score;

  /// What the ASR model heard.
  final String transcript;
  final bool accepted;

  const TajweedTestResult(
    super.index, {
    required this.score,
    required this.transcript,
    required this.accepted,
  });

  @override
  List<Object?> get props => [index, score, transcript, accepted];
}

class TajweedTestError extends TajweedTestState {
  final String messageKey;
  const TajweedTestError(super.index, this.messageKey);

  @override
  List<Object?> get props => [index, messageKey];
}
