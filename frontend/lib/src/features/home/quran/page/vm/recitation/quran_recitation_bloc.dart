import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/recitation_test/data/datasource/recitation_socket_client.dart';
import 'package:tajweed_ai/src/features/home/quran/recitation_test/data/models/word_verdict_model.dart';

export 'package:flutter_bloc/flutter_bloc.dart';

part 'events/quran_recitation_events.dart';
part 'states/quran_recitation_state.dart';
part 'usecases/quran_recitation_uc.dart';

/// Drives in-page recitation: the user recites (a page, or a surah from a
/// verse), audio streams to the backend, and per-word verdicts come back and
/// are painted directly onto the rendered Quran words ([QuranLineText]).
///
/// Reuses the surah-agnostic [RecitationSocketClient] + [WordVerdictModel] from
/// the recitation_test prototype. Extends plain [Bloc] (not BaseBloc) because
/// it is owned by a `BlocProvider`, whose dispose calls [close] directly.
class QuranRecitationBloc
    extends Bloc<QuranRecitationEvent, QuranRecitationState> {
  final QuranPageDao _dao;
  final RecitationSocketClient _socket;

  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioSub;
  StreamSubscription<RecitationServerMessage>? _socketSub;

  /// The words of the current session (for [RestartRecitation]).
  List<({int id, String text})> _currentWords = const [];
  int? _currentPageNo;

  QuranRecitationBloc({
    required QuranPageDao dao,
    required RecitationSocketClient socket,
  })  : _dao = dao,
        _socket = socket,
        super(const QuranRecitationState()) {
    on<EnterRecitationMode>(onEnterMode);
    on<ExitRecitationMode>(onExitMode);
    on<ToggleHideText>(onToggleHideText);
    on<StartPageRecitation>(onStartPageRecitation);
    on<StartRecitation>(onStartRecitation);
    on<RestartRecitation>(onRestart);
    on<StopRecording>(onStopRecording);
    on<RecitationPageChanged>(onPageChanged);
    on<AudioChunkReady>(onAudioChunkReady);
    on<VerdictReceived>(onVerdictReceived);
    on<RecitationFailed>(onRecitationFailed);
  }

  // Convenience API for the widgets.
  void enterMode() => add(const EnterRecitationMode());
  void exitMode() => add(const ExitRecitationMode());
  void toggleHideText() => add(const ToggleHideText());
  void startPage(int pageNo, List<({int id, String text})> words) =>
      add(StartPageRecitation(pageNo: pageNo, words: words));
  void startSurah(int surah, int startAyah) =>
      add(StartRecitation(surah, startAyah));
  void restart() => add(const RestartRecitation());
  void stopRecording() => add(const StopRecording());
  void notifyPageChanged(int pageNo) => add(RecitationPageChanged(pageNo));

  @override
  Future<void> close() async {
    await _teardownSession();
    await _recorder.dispose();
    return super.close();
  }
}
