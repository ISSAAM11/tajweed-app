import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/surah_listing_screen.dart';

final quranListingRoute = GoRoute(
  path: "/quran-listing",
  builder: (_, __) => SurahListingScreen(),
);
