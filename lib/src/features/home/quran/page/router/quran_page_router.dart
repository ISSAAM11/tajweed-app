import 'package:go_router/go_router.dart' show GoRoute;
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/quran_page_screen.dart';

final quranPageRoute = GoRoute(
  path: "/quran-page",
  builder: (context, state) {
    final args = QuranPageArgs.fromQuery(state.uri.queryParameters);
    return QuranPageScreen(args: args);
  },
);

class QuranPageArgs {
  final VerseKey verseKey;
  final PartitionMode mode;

  const QuranPageArgs({required this.verseKey, required this.mode});

  /// From query params (surah, ayah, mode)
  factory QuranPageArgs.fromQuery(Map<String, String> params) {
    final surah = int.tryParse(params['surah'] ?? '') ?? 1;
    final ayah = int.tryParse(params['ayah'] ?? '') ?? 1;
    final modeStr = params['mode'] ?? PartitionMode.page.name;

    final mode = PartitionMode.values.firstWhere(
      (m) => m.name == modeStr,
      orElse: () => PartitionMode.page,
    );

    return QuranPageArgs(verseKey: VerseKey(surah, ayah), mode: mode);
  }

  /// To query string map
  Map<String, String> toQuery() => {
    'surah': verseKey.surah.toString(),
    'ayah': verseKey.ayah.toString(),
    'mode': mode.name,
  };
}
