import 'package:equatable/equatable.dart';

sealed class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();

  @override
  List<Object?> get props => [];
}

final class RefreshHomeEvent extends HomeScreenEvent {
  const RefreshHomeEvent();
}
