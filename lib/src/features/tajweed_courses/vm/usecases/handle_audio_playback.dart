part of '../tajweed_rule_detail_bloc.dart';

extension on TajweedRuleDetailBloc {
  Future<void> onPlayExample(
    PlayExampleRequested event,
    Emitter<TajweedRuleDetailState> emit,
  ) async {
    if (state is Playing && (state as Playing).exampleId == event.exampleId) {
      await _player.stop();
      emit(const Idle());
      return;
    }

    await _player.stop();
    await _player.setAsset(event.audioAsset);
    _player.play();
    emit(Playing(event.exampleId));
  }

  Future<void> onStop(
    StopRequested event,
    Emitter<TajweedRuleDetailState> emit,
  ) async {
    await _player.stop();
    emit(const Idle());
  }

  Future<void> onPlaybackCompleted(
    _PlaybackCompleted event,
    Emitter<TajweedRuleDetailState> emit,
  ) async {
    emit(const Idle());
  }
}
