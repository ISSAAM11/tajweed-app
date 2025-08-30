// import 'package:tajweed_ai/src/base/bloc/exports.dart';
// import 'package:tajweed_ai/src/features/home/quran/datasource/quran_datasource.dart';

// import 'quran_page_events.dart';
// import 'quran_page_state.dart';

// class QuranPageBloc extends BaseBloc<QuranPageEvent, QuranPageState> {
//   final QuranDatasource _datasource;

//   QuranPageBloc(
//     this._datasource, {
//     PartitionMode initialMode = PartitionMode.surah,
//   }) : super(QuranPageLoadingState(initialMode), debugginEnabled: true) {
//     on<LoadPageEvent>(_onLoadPage);
//     on<ChangePartitionModeEvent>(_onChangePartitionMode);
//   }

//   Future<void> _onLoadPage(
//     LoadPageEvent event,
//     Emitter<QuranPageState> emit,
//   ) async {
//     emit(QuranPageLoadingState(state.partitionMode));
//     try {
//       // final ayat = await _datasource.getPageAyat(event.pageId, state.partitionMode);
//       // emit(QuranPageLoadedState(state.partitionMode, ayat));
//       emit(QuranPageLoadedState(state.partitionMode, []));
//     } catch (e) {
//       emit(QuranPageErrorState(state.partitionMode, e.toString()));
//     }
//   }

//   void _onChangePartitionMode(
//     ChangePartitionModeEvent event,
//     Emitter<QuranPageState> emit,
//   ) {
//     emit(QuranPageLoadingState(event.mode));
//   }
// }
