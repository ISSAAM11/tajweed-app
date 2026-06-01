part of '../quran_recitation_bloc.dart';

/// Reason keys (resolved at the view via AppLocalizations).
const _micDeniedKey = 'recitationMicDenied';
const _connectionErrorKey = 'recitationConnectionError';
const _noWordsKey = 'recitationNoWords';

/// Arabic base-letter ranges. Marker-only rows (waqf / ayah-end ornaments)
/// match nothing and are dropped, so the expected word indices line up with
/// the verdicts the backend reports.
final _arabicLetter = RegExp('[ء-غف-يٮ-ۓ]');

extension QuranRecitationUseCases on QuranRecitationBloc {
  bool _hasArabicLetters(String text) => _arabicLetter.hasMatch(text);

  Future<void> onEnterMode(
    EnterRecitationMode event,
    Emitter<QuranRecitationState> emit,
  ) async {
    emit(state.copyWith(modeActive: true, clearError: true));
  }

  Future<void> onExitMode(
    ExitRecitationMode event,
    Emitter<QuranRecitationState> emit,
  ) async {
    await _teardownSession();
    _currentWords = const [];
    _currentPageNo = null;
    emit(const QuranRecitationState());
  }

  Future<void> onToggleHideText(
    ToggleHideText event,
    Emitter<QuranRecitationState> emit,
  ) async {
    emit(state.copyWith(hideText: !state.hideText));
  }

  Future<void> onStartPageRecitation(
    StartPageRecitation event,
    Emitter<QuranRecitationState> emit,
  ) async {
    _currentWords = event.words;
    _currentPageNo = event.pageNo;
    await _beginSession(emit, pageNo: event.pageNo);
  }

  Future<void> onStartRecitation(
    StartRecitation event,
    Emitter<QuranRecitationState> emit,
  ) async {
    // Surah-scoped (ayah popup): from the tapped ayah to the surah's end.
    final rows = await _dao.getSurahWordsFromAyah(event.surah, event.startAyah);
    _currentWords = [
      for (final row in rows)
        if (_hasArabicLetters(row.text)) (id: row.id, text: row.text),
    ];
    _currentPageNo = null;
    await _beginSession(emit, pageNo: null);
  }

  Future<void> onRestart(
    RestartRecitation event,
    Emitter<QuranRecitationState> emit,
  ) async {
    if (_currentWords.isEmpty) return;
    await _beginSession(emit, pageNo: _currentPageNo);
  }

  Future<void> onStopRecording(
    StopRecording event,
    Emitter<QuranRecitationState> emit,
  ) async {
    if (!state.recording) return;
    await _stopMic();
    _socket.sendStop();
    emit(state.copyWith(recording: false));
  }

  Future<void> onPageChanged(
    RecitationPageChanged event,
    Emitter<QuranRecitationState> emit,
  ) async {
    if (!state.modeActive) return;
    await _teardownSession();
    _currentWords = const [];
    _currentPageNo = event.pageNo;
    emit(
      state.copyWith(
        recording: false,
        pageNo: event.pageNo,
        wordIndexById: const {},
        verdicts: const {},
        clearError: true,
      ),
    );
  }

  Future<void> onAudioChunkReady(
    AudioChunkReady event,
    Emitter<QuranRecitationState> emit,
  ) async {
    _socket.sendAudio(event.chunk);
  }

  Future<void> onVerdictReceived(
    VerdictReceived event,
    Emitter<QuranRecitationState> emit,
  ) async {
    switch (event.message) {
      case VerdictMessage(:final verdict):
        final merged = {...state.verdicts, verdict.wordIndex: verdict};
        final next = state.copyWith(verdicts: merged);
        emit(next);
        // Page finished — every expected word has a final verdict: auto-stop.
        if (next.recording && next.isComplete) {
          await _stopMic();
          _socket.sendStop();
          emit(next.copyWith(recording: false));
        }
      case DoneMessage():
        await _socketSub?.cancel();
        _socketSub = null;
        await _socket.close();
      case ErrorMessage():
        add(const RecitationFailed(_connectionErrorKey));
    }
  }

  Future<void> onRecitationFailed(
    RecitationFailed event,
    Emitter<QuranRecitationState> emit,
  ) async {
    await _teardownSession();
    emit(state.copyWith(recording: false, connecting: false, errorKey: event.reasonKey));
  }

  /// Shared start: build the expected list + index map from [_currentWords],
  /// request mic, open the socket, send config, and stream audio. Resets any
  /// in-flight session first.
  Future<void> _beginSession(
    Emitter<QuranRecitationState> emit, {
    required int? pageNo,
  }) async {
    final expected = <String>[];
    final wordIndexById = <int, int>{};
    for (final word in _currentWords) {
      if (!_hasArabicLetters(word.text)) continue;
      wordIndexById[word.id] = expected.length;
      expected.add(word.text);
    }
    if (expected.isEmpty) {
      emit(
        state.copyWith(
          modeActive: true,
          recording: false,
          connecting: false,
          errorKey: _noWordsKey,
        ),
      );
      return;
    }

    await _teardownSession();

    // "Connecting" phase — also clears any prior error so a repeated failure
    // re-fires the snackbar (errorKey transitions null -> value each attempt).
    emit(
      state.copyWith(
        modeActive: true,
        recording: false,
        connecting: true,
        clearError: true,
      ),
    );

    if (!await _recorder.hasPermission()) {
      emit(
        state.copyWith(
          modeActive: true,
          recording: false,
          connecting: false,
          errorKey: _micDeniedKey,
        ),
      );
      return;
    }

    try {
      final connected = await _socket.open();
      if (!connected) {
        emit(
          state.copyWith(
            modeActive: true,
            recording: false,
            connecting: false,
            errorKey: _connectionErrorKey,
          ),
        );
        return;
      }
      _socket.sendConfig(expected);
      _socketSub = _socket.messages.listen(
        (message) => add(VerdictReceived(message)),
        onError: (_) => add(const RecitationFailed(_connectionErrorKey)),
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
        onError: (_) => add(const RecitationFailed(_connectionErrorKey)),
      );

      emit(
        state.copyWith(
          modeActive: true,
          recording: true,
          connecting: false,
          pageNo: pageNo,
          clearPageNo: pageNo == null,
          wordIndexById: wordIndexById,
          verdicts: const {},
          clearError: true,
        ),
      );
    } catch (_) {
      await _teardownSession();
      emit(
        state.copyWith(
          modeActive: true,
          recording: false,
          connecting: false,
          errorKey: _connectionErrorKey,
        ),
      );
    }
  }

  /// Stop the mic but leave the socket open so trailing final verdicts still
  /// arrive.
  Future<void> _stopMic() async {
    await _audioSub?.cancel();
    _audioSub = null;
    try {
      if (await _recorder.isRecording()) await _recorder.stop();
    } catch (_) {}
  }

  Future<void> _teardownSession() async {
    await _stopMic();
    await _socketSub?.cancel();
    _socketSub = null;
    await _socket.close();
  }
}
