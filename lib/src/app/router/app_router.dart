import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/_unclassified/shift_handover/router/shift_handover_route.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: shiftHandoverRoute.path,
  debugLogDiagnostics: true,
  routes: [shiftHandoverRoute],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
