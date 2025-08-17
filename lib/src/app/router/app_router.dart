import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/export.dart';
import '../config/app_config.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: AppConfig.initialRoute,
  debugLogDiagnostics: true,
  routes: [signInRoute, signUpRoute],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;
