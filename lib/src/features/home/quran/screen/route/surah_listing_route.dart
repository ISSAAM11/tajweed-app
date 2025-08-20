import 'package:go_router/go_router.dart' show GoRoute;

import '../surah_listing_screen.dart';

final quranRoute = GoRoute(
  path: "/quran",
  builder: (_, __) => SurahListingScreen(),
);
