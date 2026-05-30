import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/terms_of_use_screen.dart';

final termsOfUseRoute = GoRoute(
  path: '/terms-of-use',
  builder: (_, __) => const TermsOfUseScreen(),
);
