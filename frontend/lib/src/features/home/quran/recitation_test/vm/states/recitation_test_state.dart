import 'package:equatable/equatable.dart';

import '../../data/models/recitation_word.dart';
import '../../data/models/word_verdict_model.dart';

sealed class RecitationTestState extends Equatable {
  const RecitationTestState();

  @override
  List<Object?> get props => [];
}

/// Surah loaded, not recording. `verdicts` is empty on a fresh session and
/// holds the locked results after a session is stopped (until reset).
final class Idle extends RecitationTestState {
  final List<RecitationWord> words;
  final Map<int, WordVerdictModel> verdicts;

  const Idle({this.words = const [], this.verdicts = const {}});

  /// True once at least one verdict exists — the screen offers "Try Again".
  bool get hasResults => verdicts.isNotEmpty;

  @override
  List<Object?> get props => [words, verdicts];
}

/// Socket open and mic streaming; `verdicts` drives the live chip colors.
final class Listening extends RecitationTestState {
  final List<RecitationWord> words;
  final Map<int, WordVerdictModel> verdicts;

  const Listening({required this.words, this.verdicts = const {}});

  @override
  List<Object?> get props => [words, verdicts];
}

/// Mic or socket failure. `reasonKey` is an [AppLocalizations] key resolved at
/// the view; `words` is preserved so retry can re-render the surah.
final class RecitationError extends RecitationTestState {
  final String reasonKey;
  final List<RecitationWord> words;

  const RecitationError({required this.reasonKey, this.words = const []});

  @override
  List<Object?> get props => [reasonKey, words];
}
