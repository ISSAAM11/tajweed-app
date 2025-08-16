import 'package:go_router/go_router.dart' show GoRoute;

import '../view/screen/sign_in_screen.dart';

final signInRoute = GoRoute(
  path: "/sign-in",
  builder: (_, __) => SignInScreen(),
);