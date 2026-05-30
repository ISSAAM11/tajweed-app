import 'package:go_router/go_router.dart' show GoRoute;
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/tajweed_test/widgets/quran_page_screen.dart';

final tajweedRoute = GoRoute(
  path: "/tajweed-test",
  builder: (context, state) {
    final args = QuranPageArgs(
      verseKey: VerseKey(1, 1),
      mode: PartitionMode.page,
    );

    return TajweedScreen(args: args);
  },
);
