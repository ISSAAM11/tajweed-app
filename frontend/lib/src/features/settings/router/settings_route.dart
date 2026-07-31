import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/settings_screen.dart';

final settingsRoute = GoRoute(
  path: '/settings',
  builder: (_, __) => SettingsScreen(),
);
