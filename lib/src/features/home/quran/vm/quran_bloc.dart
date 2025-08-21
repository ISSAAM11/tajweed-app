import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';

import 'quran_events.dart';
import 'quran_state.dart';

part 'usecases/quran_listing_uc.dart';

class QuranBloc extends BaseBloc<QuranEvent, QuranState> {
  //! Data Sources
  final QuranDatasource _datasource;
  void selectSurah(int surahId) => add(SelectSurahEvent(surahId));

  QuranBloc(this._datasource)
    : super(QuranInitialState(), debugginEnabled: true) {
    on<LoadChaptersEvent>(_loadChapters);
    on<SelectSurahEvent>(_quranSurahSelectedEvent);
  }

  //@ LIFECYCLE
  @override
  void onInit() {
    Debugger.green('init quran bloc');
    add(LoadChaptersEvent());
    super.onInit();
  }
}
