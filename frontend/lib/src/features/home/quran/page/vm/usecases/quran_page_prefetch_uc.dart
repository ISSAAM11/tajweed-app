part of '../quran_page_bloc.dart';

extension QuranPrefetchUc on QuranPageBloc {
  Future<void> _onPrefetchPages(
    PrefetchPages event,
    Emitter<QuranPageState> emit,
  ) async {
    final blocState = state;
    final shouldLoad = !blocState.loadingPages.contains(event.pageNo);

    if (!shouldLoad) return;

    Debugger.cyan('Loading page ${event.pageNo}');

    emit(
      blocState.copyWith(
        loadingPages: {...blocState.loadingPages, event.pageNo},
      ),
    );

    try {
      final pageContent = await pageDataSource.getPageContent(event.pageNo);
      final updatedLoading = {...blocState.loadingPages}..remove(event.pageNo);

      emit(blocState.copyWith(page: pageContent, loadingPages: updatedLoading));
    } catch (e, st) {
      Debugger.red("Prefetch error: $e");
      Debugger.red(st);

      emit(
        blocState.copyWith(
          loadingPages: {...blocState.loadingPages}..remove(event.pageNo),
        ),
      );
    }
  }

  Future<void> _prefetchNeighborPartitions(
    PrefetchNeighborPartitions event,
    Emitter<QuranPageState> emit,
  ) async {
    if (state is! QuranPageLoaded) return;

    final snapshot = snapshotService.snapshot;

    // Get previous + next partition IDs
    final prevId = event.partitionId - 1;
    final nextId = event.partitionId + 1;
    final maxId = snapshotService.getTotalByMode(snapshot);

    final neighborIds = <int>[];
    if (prevId >= 1) neighborIds.add(prevId);
    if (nextId <= maxId) neighborIds.add(nextId);

    // Prefetch the first page of each neighbor partition
    for (final pid in neighborIds) {
      final neighborPage = snapshot.pageByMode(pid);
      add(PrefetchPages(neighborPage));
    }
  }
}
