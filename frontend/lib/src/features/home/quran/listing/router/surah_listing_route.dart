import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/surah_listing_screen.dart';
import 'listing_destination.dart';

final quranListingRoute = GoRoute(
  path: "/quran-listing",
  builder: (_, state) => SurahListingScreen(
    dest: ListingDestination.fromQuery(state.uri.queryParameters['dest']),
  ),
);
