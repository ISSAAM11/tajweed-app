import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';

sealed class QuranListingEvent extends Equatable {
  const QuranListingEvent();

  @override
  List<Object?> get props => [];
}

final class LoadListingDataEvent extends QuranListingEvent {}

final class SelectSurahEvent extends QuranListingEvent {
  final int surahId;
  const SelectSurahEvent(this.surahId);

  @override
  List<Object?> get props => [surahId];
}

final class ListWithJuz extends QuranListingEvent {
  const ListWithJuz();
}

class ChangeListingModeEvent extends QuranListingEvent {
  final PartitionMode mode;
  const ChangeListingModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}
