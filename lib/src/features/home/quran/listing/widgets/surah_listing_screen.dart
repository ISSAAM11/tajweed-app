import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/binding/quran_listing_deps.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_state.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';

import 'last_selected_surah_widget.dart';
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
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            toolbarHeight: 220,
            elevation: 0,
            leadingWidth: 100,
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            ],
            title: const Text('Tajweed App', style: AppFonts.appBarTitle),
          ),
        ),
      ),
      body: Column(
        children: [
          _LastSelectedSurahSection(),
          Expanded(child: SurahListingBody(state)),
        ],
      ),
    );
  }
}

class _LastSelectedSurahSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lastSurahService = get<LastSelectedSurahService>();
    final lastSelectedPage = lastSurahService.get();

    if (lastSelectedPage == null) return const SizedBox.shrink();

    return LastSelectedSurahWidget(
      lastSurah: lastSelectedPage,
      onContinue: () {
        final args = QuranPageArgs(
          verseKey: lastSelectedPage.verseKey,
          mode: PartitionMode.page,
        );
        context.push(
          Uri(
            path: "/quran-page",
            queryParameters: args.toQuery(),
          ).toString(), // move to surah index
        );
      },
    );
  }
}
