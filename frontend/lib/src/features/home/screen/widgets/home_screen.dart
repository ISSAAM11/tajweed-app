import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/last_read_navigation.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/screen/binding/home_screen_deps.dart';
import 'package:tajweed_ai/src/features/home/screen/data/models/home_action.dart';
import 'package:tajweed_ai/src/features/home/screen/vm/home_screen_bloc.dart';
import 'package:tajweed_ai/src/features/home/screen/vm/home_screen_state.dart';

import 'home_action_grid.dart';
import 'home_header.dart';

final class HomeScreen extends Feature<HomeScreenBloc, HomeScreenState> {
  HomeScreen({super.key})
    : super(dependencies: HomeScreenDependencies().inject);

  @override
  Widget build(BuildContext context, HomeScreenState state) {
    final lastReadService = get<LastSelectedSurahService>();
    final metrics = AppMetrics.homeScreen;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: HomeHeader(
        onMenu: () {},
        onSearch: () {},
        onNotifications: () => context.push('/settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // The home card follows whichever flow the user touched last, and
            // rebuilds on every save so it is right after popping back from a
            // surah — this screen stays alive underneath, so its bloc state
            // alone would go stale.
            ValueListenableBuilder<int>(
              valueListenable: lastReadService.revision,
              builder: (context, _, __) {
                final lastSelected = lastReadService.mostRecent();
                return _DarkShelfWithCard(
                  lastSelected: lastSelected,
                  onContinue: () => openLastRead(context, lastSelected),
                );
              },
            ),
            Padding(
              padding: metrics.bodyPaddingSubtitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(child: _SectionTitle()),
                  SizedBox(height: metrics.sectionBottomSpacing),
                  HomeActionGrid(
                    actions: _buildActions(context),
                    onActionTap: (action) => _onActionTap(context, action),
                  ),
                  SizedBox(height: AppMetrics.spacing.md),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onActionTap(BuildContext context, HomeAction action) {
    final route = action.targetRoute;
    if (route == null) {
      appMessenger.showSnackBar(
        CommonSnackbar(
          message: AppLocalizations.of(context)!.comingSoon,
          type: SnackbarType.info,
        ),
      );
      return;
    }
    context.push(route);
  }
}

class _SectionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.homeSectionTitle,
      style: AppFonts.lato
          .withSize(FontSizes.title)
          .withColor(Theme.of(context).colorScheme.onSurfaceVariant)
          .medium(),
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

List<HomeAction> _buildActions(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    HomeAction(
      title: l10n.homeTajweedLessons,
      levelLabel: l10n.homeLevelOne,
      progressCurrent: 4,
      progressTotal: 10,
      iconAsset: AppImages.tajweedLessonsIcon,
      highlighted: true,
      targetRoute: '/tajweed-courses',
    ),
    HomeAction(
      title: l10n.homeQuranRecitation,
      actionLabel: l10n.homeStartRecitation,
      iconAsset: AppImages.quranRecitationIcon,
      highlighted: false,
      targetRoute: '/quran-listing',
    ),
    HomeAction(
      title: l10n.homeTajweedTest,
      actionLabel: l10n.homeStartTest,
      iconAsset: AppImages.tajweedTestIcon,
      highlighted: true,
      targetRoute: '/tajweed-test',
    ),
    HomeAction(
      title: l10n.homeQuranHifth,
      actionLabel: l10n.homeStartHifth,
      iconAsset: AppImages.quranHifthIcon,
      highlighted: false,
      targetRoute: '/quran-listing?dest=hifth',
    ),
  ];
}
