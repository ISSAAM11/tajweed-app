import 'package:equatable/equatable.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object?> get props => [];
}

/// The last-read position deliberately does not live here. It is owned by
/// [LastSelectedSurahService] and watched directly by the card, so the two
/// flows' bookmarks cannot go stale behind a screen that stays alive while the
/// user reads.
final class HomeReady extends HomeScreenState {
  final int refreshTick;

  const HomeReady({this.refreshTick = 0});

  @override
  List<Object?> get props => [refreshTick];
}
