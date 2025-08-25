// part of '../quran_listing/quran_listing_bloc.dart';

// extension QuranPageUC on QuranPageBloc {
//   Future<void> _loadPage(
//     LoadPageEvent event,
//     Emitter<QuranPageState> emit,
//   ) async {
//     emit(
//       QuranPageLoadingState(
//         state is QuranPageState
//             ? (state as QuranPageState).partitionMode
//             : PartitionMode.surah,
//       ),
//     );

//     try {
//       // final mode = state is QuranPageState
//       //     ? (state as QuranPageState).partitionMode
//       //     : PartitionMode.surah;

//       // final ayat = await _datasource.getPageData(
//       //   partitionId: event.partitionId,
//       //   mode: mode,
//       // );

//       // emit(QuranPageLoadedState(mode));
//     } catch (e) {
//       final mode = state.partitionMode;
//       emit(QuranPageErrorState(mode, e.toString()));
//     }
//   }

//   void _changePartitionMode(
//     ChangePartitionModeEvent event,
//     Emitter<QuranPageState> emit,
//   ) {
//     Debugger.blue('Partition mode changed: ${event.mode}');
//     // Switch partition mode & reset to loading
//     emit(QuranPageLoadingState(event.mode));
//   }
// }
