import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/1_sign_in/router/sign_in_route.dart';
import '../../features/auth/1_sign_in/view/screen/sign_in_screen.dart';

final router = GoRouter(
  navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'root'),
  initialLocation: SignInScreen.path,
  debugLogDiagnostics: true,
  routes: [
    signInRoute,
    
    // shiftHandoverRoute,
  ],
);

BuildContext globalContext = router.routerDelegate.navigatorKey.currentContext!;

