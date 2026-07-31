import 'package:go_router/go_router.dart';

import '../widgets/tajweed_rule_detail_screen.dart';

final tajweedRuleDetailRoute = GoRoute(
  path: '/tajweed-courses/:ruleId',
  builder: (_, state) => TajweedRuleDetailScreen(
    ruleId: state.pathParameters['ruleId']!,
  ),
);
