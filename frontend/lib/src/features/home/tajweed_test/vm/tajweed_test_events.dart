part of 'tajweed_test_bloc.dart';

sealed class TajweedTestEvent extends Equatable {
  const TajweedTestEvent();
  @override
  List<Object?> get props => [];
}

class StartRecording extends TajweedTestEvent {
  const StartRecording();
}

class StopAndEvaluate extends TajweedTestEvent {
  const StopAndEvaluate();
}

class RetryTest extends TajweedTestEvent {
  const RetryTest();
}

class NextTest extends TajweedTestEvent {
  const NextTest();
}
