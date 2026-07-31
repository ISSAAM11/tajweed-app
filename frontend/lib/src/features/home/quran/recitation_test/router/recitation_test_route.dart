import 'package:go_router/go_router.dart';

import '../widgets/recitation_test_screen.dart';

final recitationTestRoute = GoRoute(
  path: '/recitation-test',
  builder: (context, state) => RecitationTestScreen(),
);
