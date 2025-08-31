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
  const ChangePartitionMode(this.newMode);

  @override
  List<Object?> get props => [newMode];
}

// user scrolled vertically
class VerticalIndexChanged extends QuranPageEvent {
  final int newIndex;
  const VerticalIndexChanged(this.newIndex);
  @override
  List<Object?> get props => [newIndex];
}

// user swiped horizontally
class HorizontalIndexChanged extends QuranPageEvent {
  final int newPartitionId;
  const HorizontalIndexChanged(this.newPartitionId);
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
