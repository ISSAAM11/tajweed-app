import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/my_account_screen.dart';

final myAccountRoute = GoRoute(
  path: '/my-account',
  builder: (_, __) => const MyAccountScreen(),
);
