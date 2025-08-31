import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/screen/router/surah_listing_route.dart';

import '../../features/auth/export.dart';
import '../config/app_config.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: AppConfig.initialRoute,
  debugLogDiagnostics: true,
  routes: [signInRoute, signUpRoute, quranListingRoute, quranPageRoute],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
