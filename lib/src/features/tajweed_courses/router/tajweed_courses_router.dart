import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/tajweed_courses_screen.dart';

final tajweedCoursesRoute = GoRoute(
  path: '/tajweed-courses',
  builder: (_, __) => const TajweedCoursesScreen(),
);
