part of '../tajweed_test_bloc.dart';

extension TajweedTestUc on TajweedTestBloc {
  Future<void> _onStartRecording(
    StartRecording event,
    Emitter<TajweedTestState> emit,
  ) async {
    if (!await _recorder.hasPermission()) {
      emit(TajweedTestError(state.index, 'recitationMicDenied'));
      return;
    }
    final dir = await getTemporaryDirectory();
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.wav,
        sampleRate: 16000,
        numChannels: 1,
      ),
      path: '${dir.path}/tajweed_test.wav',
    );
    emit(TajweedTestRecording(state.index));
  }

  Future<void> _onStopAndEvaluate(
    StopAndEvaluate event,
    Emitter<TajweedTestState> emit,
  ) async {
    final path = await _recorder.stop();
    if (path == null) {
      emit(TajweedTestReady(state.index));
      return;
    }
    emit(TajweedTestEvaluating(state.index));
    try {
      final bytes = await File(path).readAsBytes();
      final transcript = await _eval.transcribe(bytes);
      final item = state.item;
      final score = arabicSimilarity(item.displayText, transcript);
      emit(TajweedTestResult(
        state.index,
        score: score,
        transcript: transcript,
        accepted: score >= item.threshold,
      ));
    } on ModelLoadingException {
      emit(TajweedTestError(state.index, 'tajweedTestModelLoading'));
    } catch (_) {
      emit(TajweedTestError(state.index, 'tajweedTestEvalError'));
    }
  }

  void _onRetry(RetryTest event, Emitter<TajweedTestState> emit) =>
      emit(TajweedTestReady(state.index));

  void _onNext(NextTest event, Emitter<TajweedTestState> emit) =>
      emit(TajweedTestReady((state.index + 1) % tajweedTestItems.length));
}
