import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_events.dart';

import 'quran_listing_state.dart';

part 'usecases/quran_listing_uc.dart';

class QuranListingBloc extends BaseBloc<QuranListingEvent, QuranListingState> {
  //! Data Sources
  final QuranListingDatasource _datasource;
  PartitionMode currentListingMode;

  void changeListingMode(PartitionMode mode) =>
      add(ChangeListingModeEvent(mode));

  QuranListingBloc(this._datasource, this.currentListingMode)
    : super(
        QuranListingInitialState(currentListingMode: currentListingMode),
        debugginEnabled: true,
      ) {
    on<LoadListingDataEvent>(_loadListingData);

    on<ChangeListingModeEvent>(_changeListingMode);

    // Initial fetch
    add(LoadListingDataEvent());
  }
}
