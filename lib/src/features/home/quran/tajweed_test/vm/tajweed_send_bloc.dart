import 'package:tajweed_ai/src/base/bloc/base_bloc.dart';

import '../services/tajweed_send_service.dart';

// Events
sealed class TajweedSendEvent {}

final class SendTestPongEvent extends TajweedSendEvent {}

// States
sealed class TajweedSendState {
  const TajweedSendState();
}

final class TajweedSendIdle extends TajweedSendState {
  const TajweedSendIdle();
}

final class TajweedSendLoading extends TajweedSendState {
  const TajweedSendLoading();
}

final class TajweedSendSuccess extends TajweedSendState {
  const TajweedSendSuccess();
}

final class TajweedSendError extends TajweedSendState {
  final String message;

  const TajweedSendError(this.message);
}

/// Very small Bloc that just sends a "pong" test payload.
final class TajweedSendBloc
    extends BaseBloc<TajweedSendEvent, TajweedSendState> {
  final TajweedSendService _service;

  TajweedSendBloc(this._service)
    : super(const TajweedSendIdle(), debugginEnabled: false) {
    on<SendTestPongEvent>(_onSendTestPong);
  }

  void sendTestPong() => add(SendTestPongEvent());

  Future<void> _onSendTestPong(
    SendTestPongEvent event,
    Emitter<TajweedSendState> emit,
  ) async {
    emit(const TajweedSendLoading());
    try {
      await _service.sendTestPong();
      emit(const TajweedSendSuccess());
    } catch (e) {
      emit(TajweedSendError(e.toString()));
    }
  }
}
