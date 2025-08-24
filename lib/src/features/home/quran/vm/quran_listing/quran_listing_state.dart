import 'package:equatable/equatable.dart';
import 'package:tajweed_ai/src/database/app_database.dart' show ChapterRow;
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';

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
  final List<ChapterRow> chapters;
  final List<({int pageNumber, VerseKey verseKey, String ayahText})>? pages;
  final List<({int juzNumber, VerseKey verseKey, String ayahText})>? juzs;
  final List<
    ({int juzNumber, HizbFraction fraction, VerseKey verseKey, String ayahText})
  >?
  hizbs;
  final List<({int rukuNumber, VerseKey verseKey, String ayahText})>? rukus;

  const QuranListingLoadedState({
    required super.currentListingMode, // ✅ super-parameter name must match the base field
    required this.chapters,
    this.pages,
    this.juzs,
    this.rukus,
    this.hizbs,
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
    List<ChapterRow>? chapters,
    List<({int pageNumber, VerseKey verseKey, String ayahText})>? pages,
    List<({int juzNumber, VerseKey verseKey, String ayahText})>? juzs,
    List<
      ({
        int juzNumber,
        HizbFraction fraction,
        VerseKey verseKey,
        String ayahText,
      })
    >?
    hizbs,
    List<({int rukuNumber, VerseKey verseKey, String ayahText})>? rukus,
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
