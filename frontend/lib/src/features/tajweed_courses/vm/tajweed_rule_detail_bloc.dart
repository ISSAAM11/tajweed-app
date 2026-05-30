import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tajweed_ai/src/base/bloc/base_bloc.dart';

import 'states/tajweed_rule_detail_state.dart';

export 'package:flutter_bloc/flutter_bloc.dart';
export 'states/tajweed_rule_detail_state.dart';

part 'events/tajweed_rule_detail_events.dart';
part 'usecases/handle_audio_playback.dart';

class TajweedRuleDetailBloc
    extends BaseBloc<TajweedRuleDetailEvent, TajweedRuleDetailState> {
  final String ruleId;
  late final AudioPlayer _player;

  TajweedRuleDetailBloc({required this.ruleId}) : super(const Idle()) {
    on<PlayExampleRequested>(onPlayExample);
    on<StopRequested>(onStop);
    on<_PlaybackCompleted>(onPlaybackCompleted);
  }

  void playExample(String exampleId, String audioAsset) =>
      add(PlayExampleRequested(exampleId: exampleId, audioAsset: audioAsset));

  void stopPlayback() => add(const StopRequested());

  @override
  void onInit() {
    _player = AudioPlayer();
    _player.playerStateStream.listen((playerState) {
      if (playerState.processingState == ProcessingState.completed) {
        add(const _PlaybackCompleted());
      }
    });
    super.onInit();
  }

  @override
  void onDispose() {
    _player.dispose();
    super.onDispose();
  }
}
