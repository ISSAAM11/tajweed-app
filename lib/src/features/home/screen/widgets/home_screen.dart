import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
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
    final lastSelected = state is HomeReady ? state.lastSelected : null;
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
            _DarkShelfWithCard(
              lastSelected: lastSelected,
              onContinue: () => _openLastSelected(context, lastSelected),
            ),
            Padding(
              padding: metrics.bodyPaddingSubtitle,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _SectionTitle(),
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

List<HomeAction> _buildActions(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    HomeAction(
      title: l10n.homeTajweedLessons,
      levelLabel: l10n.homeLevelOne,
      progressCurrent: 4,
      progressTotal: 10,
      icon: Icons.school_rounded,
      highlighted: true,
      targetRoute: '/tajweed-courses',
    ),
    HomeAction(
      title: l10n.homeQuranRecitation,
      actionLabel: l10n.homeStartRecitation,
      icon: Icons.menu_book_rounded,
      highlighted: false,
      targetRoute: '/quran-listing',
    ),
    HomeAction(
      title: l10n.homeTajweedTest,
      actionLabel: l10n.homeStartTest,
      icon: Icons.mic_rounded,
      highlighted: true,
      targetRoute: '/tajweed-test',
    ),
    HomeAction(
      title: l10n.homeQuranReflection,
      actionLabel: l10n.homeStartReflection,
      icon: Icons.lightbulb_outline_rounded,
      highlighted: false,
    ),
  ];
}
