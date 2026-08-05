import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/features/home/tajweed_test/data/tajweed_test_items.dart';
import 'package:tajweed_ai/src/features/home/tajweed_test/datasource/tajweed_eval_datasource.dart';
import 'package:tajweed_ai/src/helpers/arabic_similarity.dart';

part 'tajweed_test_events.dart';
part 'tajweed_test_states.dart';
part 'usecases/tajweed_test_uc.dart';

class TajweedTestBloc extends BaseBloc<TajweedTestEvent, TajweedTestState> {
  //! Data Sources
  final TajweedEvalDataSource _eval;

  final AudioRecorder _recorder = AudioRecorder();

  TajweedTestBloc(this._eval) : super(const TajweedTestReady(0)) {
    on<StartRecording>(_onStartRecording);
    on<StopAndEvaluate>(_onStopAndEvaluate);
    on<RetryTest>(_onRetry);
    on<NextTest>(_onNext);
  }

  @override
  Future<void> close() async {
    await _recorder.dispose();
    return super.close();
  }
}
