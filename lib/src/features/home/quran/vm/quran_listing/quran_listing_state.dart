import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_model_helper.dart';

sealed class QuranListingState extends Equatable {
  final PartitionMode currentListingMode;
  const QuranListingState({required this.currentListingMode});

  @override
  List<Object?> get props => [currentListingMode];
}

final class QuranListingInitialState extends QuranListingState {
  // Default to surah on very first render. (Only here; other states preserve mode.)
  const QuranListingInitialState({required super.currentListingMode});
}

final class QuranListingLoadingState extends QuranListingState {
  // Preserve whatever mode the Bloc passes in.
  const QuranListingLoadingState({required super.currentListingMode});
}

final class QuranListingLoadedState extends QuranListingState {
  final List<ChapterItem> chapters;
  final List<PageItem> pages;
  final List<JuzItem> juzs;
  final List<HizbItem> hizbs;
  final List<RukuItem> rukus;

  const QuranListingLoadedState({
    required super.currentListingMode, // ✅ super-parameter name must match the base field
    required this.chapters,
    required this.pages,
    required this.juzs,
    required this.rukus,
    required this.hizbs,
  });

  @override
  List<Object?> get props => [
    chapters,
    pages,
    juzs,
    rukus,
    hizbs,
    currentListingMode,
  ];

  QuranListingLoadedState copyWith({
    PartitionMode? currentListingMode,
    List<ChapterItem>? chapters,
    List<PageItem>? pages,
    List<JuzItem>? juzs,
    List<HizbItem>? hizbs,
    List<RukuItem>? rukus,
  }) {
    return QuranListingLoadedState(
      currentListingMode: currentListingMode ?? this.currentListingMode,
      chapters: chapters ?? this.chapters,
      pages: pages ?? this.pages,
      juzs: juzs ?? this.juzs,
      hizbs: hizbs ?? this.hizbs,
      rukus: rukus ?? this.rukus,
    );
  }

  /// Unify current data access
  List<PartitionItem> get items {
    switch (currentListingMode) {
      case PartitionMode.surah:
        return chapters;
      case PartitionMode.juz:
        return juzs;
      case PartitionMode.page:
        return pages;
      case PartitionMode.hizb:
        return hizbs;
      case PartitionMode.ruku:
        return rukus;
    }
  }
}

final class QuranListingErrorState extends QuranListingState {
  final String message;
  const QuranListingErrorState({
    required super.currentListingMode,
    required this.message,
  });

  @override
  List<Object?> get props => [currentListingMode, message];
}
