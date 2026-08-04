import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/router/hifth_route.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';

/// Resumes [last] in the flow that saved it — the mushaf and the hifth screen
/// keep separate bookmarks, and the home card can show either one.
///
/// Shared by the home screen and the surah listing so the two cannot drift.
void openLastRead(BuildContext context, LastSelectedPage? last) {
  if (last == null) return;

  final destination = switch (last.source) {
    LastReadSource.hifth => Uri(
      path: '/hifth',
      queryParameters: HifthArgs(surah: last.verseKey.surah).toQuery(),
    ),
    LastReadSource.quranPage => Uri(
      path: '/quran-page',
      queryParameters: QuranPageArgs(
        verseKey: last.verseKey,
        mode: PartitionMode.page,
      ).toQuery(),
    ),
  };

  context.push(destination.toString());
}
