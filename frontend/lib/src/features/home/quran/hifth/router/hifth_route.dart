import 'package:go_router/go_router.dart' show GoRoute;

import '../widgets/hifth_screen.dart';

final hifthRoute = GoRoute(
  path: "/hifth",
  builder: (context, state) {
    final args = HifthArgs.fromQuery(state.uri.queryParameters);
    return HifthScreen(args: args);
  },
);

class HifthArgs {
  final int surah;

  const HifthArgs({required this.surah});

  factory HifthArgs.fromQuery(Map<String, String> params) =>
      HifthArgs(surah: int.tryParse(params['surah'] ?? '') ?? 1);

  Map<String, String> toQuery() => {'surah': surah.toString()};
}
