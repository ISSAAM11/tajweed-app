import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:record/record.dart';
import 'package:tajweed_ai/src/base/bloc/base_bloc.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';

import '../data/datasource/recitation_socket_client.dart';
import '../data/models/recitation_word.dart';
import '../data/models/word_verdict_model.dart';
import 'states/recitation_test_state.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'states/recitation_test_state.dart';

part 'events/recitation_test_events.dart';
part 'usecases/recitation_test_uc.dart';

/// v1 recites Al-Fatiha only (design.md scope).
const int _alFatihaSurah = 1;

class RecitationTestBloc
    extends BaseBloc<RecitationTestEvent, RecitationTestState> {
  final QuranPageDao _dao;
  final RecitationSocketClient _socket;

  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _audioSub;
  StreamSubscription<RecitationServerMessage>? _socketSub;

  RecitationTestBloc({
    required QuranPageDao dao,
    required RecitationSocketClient socket,
  }) : _dao = dao,
       _socket = socket,
       super(const Idle()) {
    on<LoadWords>(onLoadWords);
    on<StartSession>(onStartSession);
    on<AudioChunkReady>(onAudioChunkReady);
    on<VerdictReceived>(onVerdictReceived);
    on<StopSession>(onStopSession);
    on<Reset>(onReset);
    on<_SessionFailed>(onSessionFailed);
  }

  void start() => add(const StartSession());
  void stop() => add(const StopSession());
  void reset() => add(const Reset());

  @override
  void onReady() {
    add(const LoadWords());
    super.onReady();
  }

  @override
  void onDispose() {
    _audioSub?.cancel();
    _socketSub?.cancel();
    _recorder.dispose();
    _socket.close();
    super.onDispose();
  }
}
