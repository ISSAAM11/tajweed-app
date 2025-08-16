import 'package:go_router/go_router.dart' show GoRoute;

import '../view/screen/sign_in_screen.dart';

final signInRoute = GoRoute(
  path: SignInScreen.path,
  builder: (_, __) => SignInScreen(),
);
