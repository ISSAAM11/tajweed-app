import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/audio_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/ayah_segment.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/audio_download_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/quran_audio_player_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';

part 'audio_player_events.dart';
part 'audio_player_state.dart';
part 'usecases/audio_player_uc.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioDao _dao;
  final AudioDownloadService _downloader;
  final QuranAudioPlayerService _player;
  final CheikhCubit _cheikh;

  StreamSubscription<int?>? _indexSub;
  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<Object>? _playerErrorSub;

  AudioPlayerBloc({
    required AudioDao dao,
    required AudioDownloadService downloader,
    required QuranAudioPlayerService player,
    required CheikhCubit cheikh,
  })  : _dao = dao,
        _downloader = downloader,
        _player = player,
        _cheikh = cheikh,
        super(const AudioIdle()) {
    on<RequestPlayAyah>(_onRequestPlay);
    on<RequestPlayPage>(_onRequestPlay);
    on<RequestPlaySurah>(_onRequestPlay);
    on<ConfirmDownload>(_onConfirmDownload);
    on<CancelDownload>(_onCancelDownload);
    on<PauseAudio>(_onPause);
    on<ResumeAudio>(_onResume);
    on<StopAudio>(_onStop);
    on<SkipNext>(_onSkipNext);
    on<SkipPrevious>(_onSkipPrevious);
    on<_IndexAdvanced>(_onIndexAdvanced);
    on<_PlaybackCompleted>(_onPlaybackCompleted);
    on<_PlaybackError>(_onPlaybackError);

    _playerStateSub = _player.playerStateStream.listen((ps) {
      if (ps.processingState == ProcessingState.completed) {
        add(const _PlaybackCompleted());
      }
    });

    _playerErrorSub = _player.playerErrorStream.listen((_) {
      add(const _PlaybackError());
    });
  }

  void _subscribeToIndex(List<AyahSegment> queue) {
    _indexSub?.cancel();
    _indexSub = _player.currentIndexStream.listen((index) {
      if (index != null && index < queue.length) {
        add(_IndexAdvanced(index, queue));
      }
    });
  }

  @override
  Future<void> close() async {
    await _indexSub?.cancel();
    await _playerStateSub?.cancel();
    await _playerErrorSub?.cancel();
    await _player.dispose();
    return super.close();
  }
}
