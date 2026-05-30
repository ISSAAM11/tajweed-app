part of '../recitation_test_bloc.dart';

/// Reason keys (resolved at the view via AppLocalizations).
const _micDeniedKey = 'recitationMicDenied';
const _connectionErrorKey = 'recitationConnectionError';

/// Arabic base-letter ranges (hamza..ghayn, feh..yeh, and U+066E..U+06D3 which
/// covers the Farsi yeh ی the QPC text uses). Deliberately excludes the
/// combining diacritic / waqf / ayah-mark ranges, so marker-only rows (e.g.
/// "۟ۙ") match nothing and are filtered out of the recitable word list.
final _arabicLetter = RegExp('[ء-غف-يٮ-ۓ]');

extension on RecitationTestBloc {
  List<RecitationWord> get _words => switch (state) {
    Idle(:final words) => words,
    Listening(:final words) => words,
    RecitationError(:final words) => words,
  };

  Future<void> onLoadWords(
    LoadWords event,
    Emitter<RecitationTestState> emit,
  ) async {
    // Each row carries a QPC glyph (text_, shown on screen) and the plain
    // Arabic spelling (plainText, matched against speech-to-text). Pause/ayah
    // markers have no letters in plainText — skip them so indices line up with
    // the verdicts the backend reports.
    final rows = await _dao.getWordsForSurah(_alFatihaSurah);
    final words = [
      for (final row in rows)
        if (_hasArabicLetters(row.plainText))
          RecitationWord(glyph: row.text_, expected: row.plainText),
    ];
    emit(Idle(words: words));
  }

  /// True when [text] contains at least one Arabic base letter, i.e. it is a
  /// real word and not a standalone diacritic / waqf / ayah-end mark.
  bool _hasArabicLetters(String text) =>
      _arabicLetter.hasMatch(text);

  Future<void> onStartSession(
    StartSession event,
    Emitter<RecitationTestState> emit,
  ) async {
    final words = _words;
    if (words.isEmpty) return;

    if (!await _recorder.hasPermission()) {
      emit(RecitationError(reasonKey: _micDeniedKey, words: words));
      return;
    }

    try {
      final connected = await _socket.open();
      if (!connected) {
        emit(RecitationError(reasonKey: _connectionErrorKey, words: words));
        return;
      }
      _socket.sendConfig([for (final word in words) word.expected]);
      _socketSub = _socket.messages.listen(
        (message) => add(VerdictReceived(message)),
        onError: (_) => add(const _SessionFailed(_connectionErrorKey)),
      );

      final audioStream = await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
      );
      _audioSub = audioStream.listen(
        (chunk) => add(AudioChunkReady(chunk)),
        onError: (_) => add(const _SessionFailed(_connectionErrorKey)),
      );

      emit(Listening(words: words));
    } catch (_) {
      await _teardownSession();
      emit(RecitationError(reasonKey: _connectionErrorKey, words: words));
    }
  }

  Future<void> onAudioChunkReady(
    AudioChunkReady event,
    Emitter<RecitationTestState> emit,
  ) async {
    _socket.sendAudio(event.chunk);
  }

  Future<void> onVerdictReceived(
    VerdictReceived event,
    Emitter<RecitationTestState> emit,
  ) async {
    switch (event.message) {
      case VerdictMessage(:final verdict):
        // Trailing finals can arrive after Stop (state Idle) — apply in both.
        final current = state;
        if (current is Listening) {
          emit(
            Listening(
              words: current.words,
              verdicts: _merge(current.verdicts, verdict),
            ),
          );
        } else if (current is Idle) {
          emit(
            Idle(
              words: current.words,
              verdicts: _merge(current.verdicts, verdict),
            ),
          );
        }
      case DoneMessage():
        await _socketSub?.cancel();
        _socketSub = null;
        await _socket.close();
      case ErrorMessage():
        add(const _SessionFailed(_connectionErrorKey));
    }
  }

  Future<void> onStopSession(
    StopSession event,
    Emitter<RecitationTestState> emit,
  ) async {
    final current = state;
    if (current is! Listening) return;

    await _audioSub?.cancel();
    _audioSub = null;
    try {
      await _recorder.stop();
    } catch (_) {}
    _socket.sendStop();

    // Stay receiving: the backend flushes final verdicts then a `done` that
    // closes the socket. Move to Idle so the button flips to "Try Again".
    emit(Idle(words: current.words, verdicts: current.verdicts));
  }

  Future<void> onReset(Reset event, Emitter<RecitationTestState> emit) async {
    final words = _words;
    await _teardownSession();
    if (words.isEmpty) {
      add(const LoadWords());
      return;
    }
    emit(Idle(words: words));
  }

  Future<void> onSessionFailed(
    _SessionFailed event,
    Emitter<RecitationTestState> emit,
  ) async {
    final words = _words;
    await _teardownSession();
    emit(RecitationError(reasonKey: event.reasonKey, words: words));
  }

  Map<int, WordVerdictModel> _merge(
    Map<int, WordVerdictModel> current,
    WordVerdictModel verdict,
  ) => {...current, verdict.wordIndex: verdict};

  Future<void> _teardownSession() async {
    await _audioSub?.cancel();
    _audioSub = null;
    await _socketSub?.cancel();
    _socketSub = null;
    try {
      if (await _recorder.isRecording()) await _recorder.stop();
    } catch (_) {}
    await _socket.close();
  }
}
