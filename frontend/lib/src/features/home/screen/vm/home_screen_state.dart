import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

sealed class HomeScreenState extends Equatable {
  const HomeScreenState();

  @override
  List<Object?> get props => [];
}

final class HomeReady extends HomeScreenState {
  final LastSelectedPage? lastSelected;
  final int refreshTick;

  const HomeReady({this.lastSelected, this.refreshTick = 0});

  @override
  List<Object?> get props => [lastSelected, refreshTick];
}
