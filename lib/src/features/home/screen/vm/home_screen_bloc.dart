import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';

import 'home_screen_events.dart';
import 'home_screen_state.dart';

part 'usecases/refresh_home_uc.dart';

class HomeScreenBloc extends BaseBloc<HomeScreenEvent, HomeScreenState> {
  final LastSelectedSurahService _lastSurahService;

  HomeScreenBloc(this._lastSurahService)
    : super(
        HomeReady(lastSelected: _lastSurahService.get()),
        debugginEnabled: true,
      ) {
    on<RefreshHomeEvent>(_refresh);
  }

  void refresh() => add(const RefreshHomeEvent());
}
