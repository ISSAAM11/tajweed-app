//? Base needed imports

import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_state.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/router/hifth_route.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/listing_destination.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/widgets/list_header.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/widgets/quran_list_view.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';

class SurahListingBody extends SubWidget<QuranListingBloc> {
  final QuranListingState state;
  final ListingDestination dest;

  const SurahListingBody(
    this.state, {
    this.dest = ListingDestination.quranPage,
    super.key,
  });

  @override
  Widget build(BuildContext context) => switch (state) {
    QuranListingLoadedState() => _QuranScreen(
      itemCount: (state as QuranListingLoadedState).items.length,
      items: (state as QuranListingLoadedState).items,
      chapters: (state as QuranListingLoadedState).chapters,
      onTap: ({required VerseKey verseKey, required PartitionMode mode}) async {
        if (dest == ListingDestination.hifth) {
          final args = HifthArgs(surah: verseKey.surah);
          context.push(
            Uri(path: "/hifth", queryParameters: args.toQuery()).toString(),
          );
          return;
        }
        final args = QuranPageArgs(verseKey: verseKey, mode: mode);
        context.push(
          Uri(path: "/quran-page", queryParameters: args.toQuery()).toString(),
        );
      },
      selectedViewMode: (state as QuranListingLoadedState).currentListingMode,
      onSelectMode: (mode) => bloc.changeListingMode(mode),
      showModeHeader: dest != ListingDestination.hifth,
    ),
    QuranListingErrorState() => Center(
      child: Text(
        '${AppLocalizations.of(context)!.errorPrefix}: '
        '${(state as QuranListingErrorState).message}',
      ),
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
  final bool showModeHeader;
  void Function({required VerseKey verseKey, required PartitionMode mode})
  onTap;
  _QuranScreen({
    required this.itemCount,
    required this.items,
    required this.chapters,
    required this.onTap,
    required this.selectedViewMode,
    required this.onSelectMode,
    this.showModeHeader = true,
  });

  @override
  Widget build(BuildContext context) => QuranListView(
    itemCount: itemCount,
    items: items,
    selectedViewMode: selectedViewMode,
    onTap: onTap,
    header: showModeHeader
        ? AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 500),
            child: ListHeader(
              selectedViewMode: selectedViewMode,
              onSelectMode: onSelectMode,
            ),
          )
        : null,
  ).safeArea();
}
