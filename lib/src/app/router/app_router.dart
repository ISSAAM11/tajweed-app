import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/surah_listing_route.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';

import '../../features/auth/export.dart';
import '../config/app_config.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: AppConfig.initialRoute,
  debugLogDiagnostics: true,
  routes: [signInRoute, signUpRoute, quranListingRoute, quranPageRoute],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
