import 'package:equatable/equatable.dart';

sealed class TajweedRuleDetailState extends Equatable {
  const TajweedRuleDetailState();

  @override
  List<Object?> get props => [];
}

final class Idle extends TajweedRuleDetailState {
  const Idle();
}

final class Playing extends TajweedRuleDetailState {
  final String exampleId;

  const Playing(this.exampleId);

  @override
  List<Object?> get props => [exampleId];
}
