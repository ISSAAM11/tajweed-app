import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/binding/quran_listing_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';

import 'quran_listing_body.dart';

final class SurahListingScreen
    extends Feature<QuranListingBloc, QuranListingState> {
  SurahListingScreen({super.key})
    : super(
        dependencies: QuranListingDependencies().inject,
        onUpdate: (context, state) => switch (state) {
          _ => null,
        },
      );

  @override
  Widget build(BuildContext context, QuranListingState state) {
    final lastSelectedPage = get<LastSelectedSurahService>().get();

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
              AppLocalizations.of(context)!.homeQuranRecitation,
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
          _DarkShelfWithCard(
            lastSelected: lastSelectedPage,
            onContinue: () => _openLastSelected(context, lastSelectedPage),
          ),
          Expanded(child: SurahListingBody(state)),
        ],
      ),
    );
  }

  void _openLastSelected(BuildContext context, LastSelectedPage? lastSelected) {
    if (lastSelected == null) return;
    final args = QuranPageArgs(
      verseKey: lastSelected.verseKey,
      mode: PartitionMode.page,
    );
    context.push(
      Uri(path: '/quran-page', queryParameters: args.toQuery()).toString(),
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
            child: LastReadingCard(
              lastSelected: lastSelected!,
              onContinue: onContinue,
            ),
          ),
        ],
      ),
    );
  }
}
