import 'package:go_router/go_router.dart' show GoRoute;

import '../view/screen/signup_screen.dart';

final signUpRoute = GoRoute(
  path: '/sign-up',
  builder: (_, __) => SignUpScreen(),
);
