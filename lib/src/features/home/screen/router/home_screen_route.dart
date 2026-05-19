import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/home_screen.dart';

final homeScreenRoute = GoRoute(
  path: "/home",
  builder: (_, __) => HomeScreen(),
);
