import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/binding/quran_listing_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_state.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/last_read_navigation.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/listing_destination.dart';

import 'quran_listing_body.dart';

final class SurahListingScreen
    extends Feature<QuranListingBloc, QuranListingState> {
  final ListingDestination dest;

  SurahListingScreen({this.dest = ListingDestination.quranPage, super.key})
    : super(
        dependencies: QuranListingDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranListingState state) {
    final lastReadService = get<LastSelectedSurahService>();
    // Each destination shows its own bookmark: the hifth listing must not
    // offer to resume where the mushaf was left, or vice versa.
    final source = switch (dest) {
      ListingDestination.hifth => LastReadSource.hifth,
      ListingDestination.quranPage => LastReadSource.quranPage,
    };

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: AppBar(
            backgroundColor: AppColors.greyDarkest,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back, color: AppColors.scaffold),
            ),
            title: Text(
              dest == ListingDestination.hifth
                  ? AppLocalizations.of(context)!.hifthTitle
                  : AppLocalizations.of(context)!.homeQuranRecitation,
              style: AppFonts.nunito
                  .withSize(FontSizes.headline3)
                  .withColor(AppColors.scaffold)
                  .semiBold(),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, color: AppColors.scaffold),
              ),
              IconButton(
                onPressed: () => context.push('/settings'),
                icon: const Icon(Icons.settings, color: AppColors.scaffold),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Rebuilds on every save, so popping back from a surah shows the
          // position just reached rather than the one captured on first build.
          ValueListenableBuilder<int>(
            valueListenable: lastReadService.revision,
            builder: (context, _, __) {
              final lastSelected = lastReadService.get(source);
              return _DarkShelfWithCard(
                lastSelected: lastSelected,
                onContinue: () => openLastRead(context, lastSelected),
              );
            },
          ),
          Expanded(child: SurahListingBody(state, dest: dest)),
        ],
      ),
    );
  }
}

class _DarkShelfWithCard extends StatelessWidget {
  final LastSelectedPage? lastSelected;
  final VoidCallback onContinue;

  const _DarkShelfWithCard({
    required this.lastSelected,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final screen = AppMetrics.homeScreen;
    final card = AppMetrics.lastSelectedSurahWidget;

    if (lastSelected == null) {
      return Container(
        height: screen.darkShelfHeight,
        decoration: BoxDecoration(
          color: AppColors.greyDarkest,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(screen.darkShelfBottomRadius),
          ),
        ),
      );
    }

    final stackHeight = screen.darkShelfHeight + card.height;
    return SizedBox(
      height: stackHeight,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screen.darkShelfHeight + (card.height / 2),
              decoration: BoxDecoration(
                color: AppColors.greyDarkest,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(screen.darkShelfBottomRadius),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: LastReadingCard.forSource(
              lastSelected: lastSelected!,
              onContinue: onContinue,
            ),
          ),
        ],
      ),
    );
  }
}
