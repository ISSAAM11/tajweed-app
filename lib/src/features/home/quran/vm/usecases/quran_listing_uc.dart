part of '../quran_listing/quran_listing_bloc.dart';

extension QuranListingUC on QuranListingBloc {
  Future<void> _loadListingData(
    LoadListingDataEvent event,
    Emitter<QuranListingState> emit,
  ) async {
    emit(
      QuranListingLoadingState(currentListingMode: state.currentListingMode),
    );
    try {
      final listingData = await _datasource.getListingData();
      emit(
        QuranListingLoadedState(
          currentListingMode: state.currentListingMode,
          chapters: listingData.chapters,
          pages: listingData.pages,
          juzs: listingData.juzs,
          rukus: listingData.rukus,
          hizbs: listingData.hizbs,
        ),
      );
    } catch (e) {
      emit(
        QuranListingErrorState(
          currentListingMode: state.currentListingMode,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _changeListingMode(
    ChangeListingModeEvent event,
    Emitter<QuranListingState> emit,
  ) async {
    if (state is QuranListingLoadedState) {
      final loaded = state as QuranListingLoadedState;
      emit(loaded.copyWith(currentListingMode: event.mode));
    } else {
      // if not loaded yet, just update the mode in current state
      emit(QuranListingLoadingState(currentListingMode: event.mode));
    }
  }

  Future<void> _selectPartitionEvent(
    SelectPartitionEvent event,
    Emitter<QuranListingState> emit,
  ) async {
    Debugger.yellow(
      'Partition selected: ${event.partitionId} ${event.fraction != null ? 'fraction ${event.fraction}' : ""} with mode: ${event.mode}',
    );
    // TODO: handle partition selection (e.g. navigate or load ayat)
  }
}
