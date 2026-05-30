import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/router/surah_listing_route.dart';
import 'package:tajweed_ai/src/features/home/quran/page/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/quran/recitation_test/router/recitation_test_route.dart';
import 'package:tajweed_ai/src/features/home/quran/tajweed_test/router/quran_page_router.dart';
import 'package:tajweed_ai/src/features/home/screen/router/home_screen_route.dart';
import 'package:tajweed_ai/src/features/legal/router/legal_router.dart';
import 'package:tajweed_ai/src/features/my_account/router/my_account_router.dart';
import 'package:tajweed_ai/src/features/settings/router/settings_route.dart';
import 'package:tajweed_ai/src/features/tajweed_courses/router/tajweed_courses_router.dart';
import 'package:tajweed_ai/src/features/tajweed_courses/router/tajweed_rule_detail_route.dart';

import '../../features/auth/export.dart';
import '../config/app_config.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: AppConfig.initialRoute,
  debugLogDiagnostics: true,
  routes: [
    signInRoute,
    signUpRoute,
    homeScreenRoute,
    quranListingRoute,
    quranPageRoute,
    recitationTestRoute,
    tajweedRoute,
    settingsRoute,
    termsOfUseRoute,
    myAccountRoute,
    tajweedCoursesRoute,
    tajweedRuleDetailRoute,
  ],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
