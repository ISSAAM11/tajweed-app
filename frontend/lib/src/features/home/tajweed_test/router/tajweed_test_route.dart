import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/tajweed_test_screen.dart';

final tajweedTestRoute = GoRoute(
  path: "/tajweed-test",
  builder: (context, state) => TajweedTestScreen(),
);
