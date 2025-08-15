import 'package:go_router/go_router.dart';

import '../view/screen/shift_handover_screen.dart';

final shiftHandoverRoute = GoRoute(
  path: ShiftHandoverScreen.path,
  builder: (_, __) => ShiftHandoverScreen(),
);