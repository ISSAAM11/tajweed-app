part of '../quran_recitation_bloc.dart';

/// Single immutable state for in-page recitation.
///
/// The page renderer ([QuranLineText]) paints verdicts onto words via
/// [verdictForWordId]; the control bar reads [modeActive]/[recording]/
/// [hideText]; the screen shows a snackbar when [errorKey] changes.
///
/// Maps:
/// - [wordIndexById]: rendered `WordRow.id` → its index in the expected-word
///   list (markers filtered out, so indices line up with backend verdicts).
/// - [verdicts]: expected index → the latest verdict for that word.
class QuranRecitationState extends Equatable {
  /// Recitation mode toggled on — the control bar is visible.
  final bool modeActive;

  /// Mic is streaming to the backend.
  final bool recording;

  /// Opening the socket / requesting the mic (between tap and streaming).
  final bool connecting;

  /// Memorization aid: hide page words, revealing each only once recited.
  final bool hideText;

  /// Page being recited (null for the surah-scoped popup flow).
  final int? pageNo;

  final Map<int, int> wordIndexById;
  final Map<int, WordVerdictModel> verdicts;

  /// Transient [AppLocalizations] key for the last failure (mic/connection),
  /// resolved at the view. Cleared on the next successful action.
  final String? errorKey;

  const QuranRecitationState({
    this.modeActive = false,
    this.recording = false,
    this.connecting = false,
    this.hideText = false,
    this.pageNo,
    this.wordIndexById = const {},
    this.verdicts = const {},
    this.errorKey,
  });

  WordVerdictModel? verdictForWordId(int wordId) {
    final index = wordIndexById[wordId];
    if (index == null) return null;
    return verdicts[index];
  }

  /// True once every expected word has a final verdict (page finished).
  bool get isComplete =>
      wordIndexById.isNotEmpty &&
      wordIndexById.values.toSet().every(
        (index) => verdicts[index]?.isFinal ?? false,
      );

  QuranRecitationState copyWith({
    bool? modeActive,
    bool? recording,
    bool? connecting,
    bool? hideText,
    int? pageNo,
    Map<int, int>? wordIndexById,
    Map<int, WordVerdictModel>? verdicts,
    String? errorKey,
    bool clearError = false,
    bool clearPageNo = false,
  }) {
    return QuranRecitationState(
      modeActive: modeActive ?? this.modeActive,
      recording: recording ?? this.recording,
      connecting: connecting ?? this.connecting,
      hideText: hideText ?? this.hideText,
      pageNo: clearPageNo ? null : (pageNo ?? this.pageNo),
      wordIndexById: wordIndexById ?? this.wordIndexById,
      verdicts: verdicts ?? this.verdicts,
      errorKey: clearError ? null : (errorKey ?? this.errorKey),
    );
  }

  @override
  List<Object?> get props => [
    modeActive,
    recording,
    connecting,
    hideText,
    pageNo,
    wordIndexById,
    verdicts,
    errorKey,
  ];
}
