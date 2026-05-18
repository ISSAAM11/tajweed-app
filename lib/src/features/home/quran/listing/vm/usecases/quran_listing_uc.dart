part of '../quran_listing_bloc.dart';

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
}
