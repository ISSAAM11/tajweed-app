import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/database/daos/ayah_meta_helper_models.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_events.dart';

import 'quran_listing_state.dart';

part '../usecases/quran_listing_uc.dart';

class QuranListingBloc extends BaseBloc<QuranListingEvent, QuranListingState> {
  //! Data Sources
  final QuranDatasource _datasource;
  PartitionMode currentListingMode;

  void selectSurah(int surahId) => add(SelectSurahEvent(surahId));
  void changeListingMode(PartitionMode mode) =>
      add(ChangeListingModeEvent(mode));

  QuranListingBloc(this._datasource, this.currentListingMode)
    : super(
        QuranListingInitialState(currentListingMode: currentListingMode),
        debugginEnabled: true,
      ) {
    on<LoadListingDataEvent>(_loadListingData);
    on<SelectSurahEvent>(_quranSurahSelectedEvent);
    on<ChangeListingModeEvent>(_changeListingMode);

    // Initial fetch
    add(LoadListingDataEvent());
  }

  //@ LIFECYCLE
  @override
  void onInit() {
    Debugger.green('init quran bloc');
    super.onInit();
  }
}
