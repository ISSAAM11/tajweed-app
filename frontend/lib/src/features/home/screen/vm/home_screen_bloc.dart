import 'package:tajweed_ai/src/base/bloc/exports.dart';

import 'home_screen_events.dart';
import 'home_screen_state.dart';

part 'usecases/refresh_home_uc.dart';

class HomeScreenBloc extends BaseBloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(const HomeReady(), debugginEnabled: true) {
    on<RefreshHomeEvent>(_refresh);
  }

  void refresh() => add(const RefreshHomeEvent());
}
