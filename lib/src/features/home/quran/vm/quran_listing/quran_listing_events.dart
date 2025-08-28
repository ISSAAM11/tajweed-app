import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

sealed class QuranListingEvent extends Equatable {
  const QuranListingEvent();

  @override
  List<Object?> get props => [];
}

final class LoadListingDataEvent extends QuranListingEvent {}

final class SelectPartitionEvent extends QuranListingEvent {
  final PartitionMode mode;
  final int partitionId;
  final HizbFraction? fraction;
  const SelectPartitionEvent({
    required this.partitionId,
    required this.mode,
    this.fraction,
  });

  @override
  List<Object?> get props => [mode, partitionId, fraction];
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
