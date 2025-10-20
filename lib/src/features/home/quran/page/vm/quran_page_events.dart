import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

sealed class QuranPageEvent extends Equatable {
  const QuranPageEvent();
  @override
  List<Object?> get props => [];
}

// init to a verse key or page
class InitToVerse extends QuranPageEvent {
  final VerseKey verseKey;
  final PartitionMode mode;
  const InitToVerse(this.verseKey, this.mode);

  @override
  List<Object?> get props => [verseKey, mode];
}

// change partition mode but keep current page
class ChangePartitionMode extends QuranPageEvent {
  final PartitionMode newMode;
  final int currentPageNo;
  const ChangePartitionMode(this.newMode, this.currentPageNo);

  @override
  List<Object?> get props => [newMode];
}

// user scrolled vertically

// user swiped horizontally
class PartitionChanged extends QuranPageEvent {
  final int newPartitionId;
  final PartitionMode partitionMode;

  const PartitionChanged(this.newPartitionId, this.partitionMode);
  @override
  List<Object?> get props => [newPartitionId];
}

class FetchPartitionContent extends QuranPageEvent {
  final int newPartitionId;
  final PartitionMode partitionMode;

  const FetchPartitionContent(this.newPartitionId, this.partitionMode);
  @override
  List<Object?> get props => [newPartitionId];
}

// prefetch request
class PrefetchPages extends QuranPageEvent {
  final List<int> pageNos;
  const PrefetchPages(this.pageNos);
  @override
  List<Object?> get props => [pageNos];
}

class PrefetchNeighborPartitions extends QuranPageEvent {
  final PartitionMode mode;
  final int partitionId;

  const PrefetchNeighborPartitions(this.mode, this.partitionId);
  @override
  List<Object?> get props => [partitionId];
}

class PartitionScrollUpdated extends QuranPageEvent {
  final int partitionId;
  final int pageIndex; // vertical index inside partition
  final ScrollDirection direction; // up / down

  const PartitionScrollUpdated({
    required this.partitionId,
    required this.pageIndex,
    required this.direction,
  });
  @override
  List<Object?> get props => [partitionId, pageIndex, direction];
}

enum ScrollDirection { up, down, idle }
