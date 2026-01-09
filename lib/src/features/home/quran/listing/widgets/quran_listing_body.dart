//? Base needed imports

import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/app/binding/app_bindings.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/services/last_selected_surah_service.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_state.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/widgets/list_header.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/widgets/quran_list_view.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';

class SurahListingBody extends SubWidget<QuranListingBloc> {
  final QuranListingState state;

  const SurahListingBody(this.state, {super.key});

  @override
  Widget build(BuildContext context) => switch (state) {
    QuranListingLoadedState() => _QuranScreen(
      itemCount: (state as QuranListingLoadedState).items.length,
      items: (state as QuranListingLoadedState).items,
      chapters: (state as QuranListingLoadedState).chapters,
      onTap: ({required VerseKey verseKey, required PartitionMode mode}) async {
        // Save last selected surah if it's a chapter item
        final loadedState = state as QuranListingLoadedState;
        if (loadedState.currentListingMode == PartitionMode.surah) {
          final chapter = loadedState.chapters.firstWhere(
            (c) => c.id == verseKey.surah,
            orElse: () => loadedState.chapters.first,
          );
          final lastSurahService = get<LastSelectedSurahService>();
          await lastSurahService.set(chapter);
        }

        final args = QuranPageArgs(verseKey: verseKey, mode: mode);
        context.push(
          Uri(path: "/quran-page", queryParameters: args.toQuery()).toString(),
        );
      },
      selectedViewMode: (state as QuranListingLoadedState).currentListingMode,
      onSelectMode: (mode) => bloc.changeListingMode(mode),
    ),
    QuranListingErrorState() => Center(
      child: Text("Error: ${(state as QuranListingErrorState).message}"),
    ),
    _ => CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
    ).resize(height: 20, width: 20).center(),
  };
}

class _QuranScreen extends StatelessWidget {
  final int itemCount;
  final List<PartitionItem> items;
  final List<ChapterItem> chapters;
  final PartitionMode selectedViewMode;
  final Function(PartitionMode) onSelectMode;
  void Function({required VerseKey verseKey, required PartitionMode mode})
  onTap;
  _QuranScreen({
    required this.itemCount,
    required this.items,
    required this.chapters,
    required this.onTap,
    required this.selectedViewMode,
    required this.onSelectMode,
  });

  @override
  Widget build(BuildContext context) => QuranListView(
    itemCount: itemCount,
    items: items,
    selectedViewMode: selectedViewMode,
    onTap: onTap,
    header: AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(milliseconds: 500),
      child: ListHeader(
        selectedViewMode: selectedViewMode,
        onSelectMode: onSelectMode,
      ),
    ),
  ).safeArea();
}
