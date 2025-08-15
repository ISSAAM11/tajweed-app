import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// import '../../features/_unclassified/shift_handover/router/shift_handover_route.dart';
import '../../features/auth/1_sign_in/router/sign_in_route.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: signInRoute.path,
  debugLogDiagnostics: true,
  routes: [
    signInRoute
    // shiftHandoverRoute,
  ],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
