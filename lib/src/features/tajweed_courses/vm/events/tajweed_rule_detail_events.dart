part of '../tajweed_rule_detail_bloc.dart';

sealed class TajweedRuleDetailEvent extends Equatable {
  const TajweedRuleDetailEvent();

  @override
  List<Object?> get props => [];
}

final class PlayExampleRequested extends TajweedRuleDetailEvent {
  final String exampleId;
  final String audioAsset;

  const PlayExampleRequested({required this.exampleId, required this.audioAsset});

  @override
  List<Object?> get props => [exampleId, audioAsset];
}

final class StopRequested extends TajweedRuleDetailEvent {
  const StopRequested();
}

final class _PlaybackCompleted extends TajweedRuleDetailEvent {
  const _PlaybackCompleted();
}
