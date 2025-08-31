import 'package:go_router/go_router.dart' show GoRoute;
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/quran_page_screen.dart';

final quranPageRoute = GoRoute(
  path: "/quran-page",
  builder: (context, state) {
    final args = QuranPageArgs.fromQueryParams(state.uri.queryParameters);
    return QuranPageScreen(args: args);
  },
);

//? ******
class QuranPageArgs {
  final PartitionMode partitionMode;
  final VerseKey verseKey;

  QuranPageArgs({required this.partitionMode, required this.verseKey});

  Map<String, String> toQueryParams() {
    return {
      'partitionMode': partitionMode.name,
      'verseKey': verseKey.toString(),
    };
  }

  /// Creates an instance from GoRouter's query parameters.
  factory QuranPageArgs.fromQueryParams(Map<String, String> params) {
    final String partitionModeString = params['partitionMode']!;
    final String verseKeyString = params['verseKey']!;

    return QuranPageArgs(
      partitionMode: PartitionMode.values.byName(partitionModeString),
      verseKey: VerseKey.parse(verseKeyString),
    );
  }

  PartitionMode get mode => partitionMode;
  VerseKey get verse => verseKey;
}
