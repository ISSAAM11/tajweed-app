import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_listing/quran_listing_events.dart';

import 'quran_listing_state.dart';

part '../usecases/quran_listing_uc.dart';

class QuranListingBloc extends BaseBloc<QuranListingEvent, QuranListingState> {
  //! Data Sources
  final QuranDatasource _datasource;
  PartitionMode currentListingMode;

  void changeListingMode(PartitionMode mode) =>
      add(ChangeListingModeEvent(mode));

  void selectPartition({
    required int partitionId,
    required PartitionMode mode,
    HizbFraction? fraction,
  }) => add(
    SelectPartitionEvent(
      partitionId: partitionId,
      mode: mode,
      fraction: fraction,
    ),
  );

  QuranListingBloc(this._datasource, this.currentListingMode)
    : super(
        QuranListingInitialState(currentListingMode: currentListingMode),
        debugginEnabled: true,
      ) {
    on<LoadListingDataEvent>(_loadListingData);
    on<SelectPartitionEvent>(_selectPartitionEvent);
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
