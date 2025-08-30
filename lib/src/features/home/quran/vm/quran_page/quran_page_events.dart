import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

sealed class QuranPageEvent extends Equatable {
  const QuranPageEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPageEvent extends QuranPageEvent {
  final int pageId;
  const LoadPageEvent(this.pageId);

  @override
  List<Object?> get props => [pageId];
}

final class ChangePartitionModeEvent extends QuranPageEvent {
  final PartitionMode mode;
  const ChangePartitionModeEvent(this.mode);

  @override
  List<Object?> get props => [mode];
}
