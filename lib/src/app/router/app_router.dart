import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../features/_unclassified/shift_handover/router/shift_handover_route.dart';
import '../../features/auth/1_sign_in/router/sign_in_route.dart';
import '../../features/home/quran/screen/route/surah_listing_route.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: quranRoute.path,
  debugLogDiagnostics: true,
  routes: [signInRoute, quranRoute],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
