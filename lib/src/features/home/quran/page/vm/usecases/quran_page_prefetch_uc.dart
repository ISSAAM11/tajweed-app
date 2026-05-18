part of '../quran_page_bloc.dart';

extension QuranPrefetchUc on QuranPageBloc {
  Future<void> _onPrefetchPages(
    PrefetchPages event,
    Emitter<QuranPageState> emit,
  ) async {
    final blocState = state;
    final toLoad = event.pageNos
        .where(
          (p) =>
              !blocState.pages.containsKey(p) &&
              !blocState.loadingPages.contains(p),
        )
        .toList();

    if (toLoad.isEmpty) return;
    Debugger.cyan('toLoad pages ${toLoad.toString()}');
    emit(
      blocState.copyWith(loadingPages: {...blocState.loadingPages, ...toLoad}),
    );

    try {
      final results = await Future.wait(
        toLoad.map(
          (p) async => MapEntry(p, await pageDataSource.getPageContent(p)),
        ),
      );

      final updatedPages = {...blocState.pages}..addEntries(results);
      final updatedLoading = {...blocState.loadingPages}..removeAll(toLoad);

      emit(
        blocState.copyWith(pages: updatedPages, loadingPages: updatedLoading),
      );
    } catch (e, st) {
      Debugger.red("Prefetch error: $e");
      Debugger.red(st);
      // cleanup loading flags on failure
      emit(
        blocState.copyWith(
          loadingPages: {...blocState.loadingPages}..removeAll(toLoad),
        ),
      );
    }
  }

  Future<void> _prefetchNeighborPartitions(
    PrefetchNeighborPartitions event,
    Emitter<QuranPageState> emit,
  ) async {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final snapshot = snapshotService.snapshot;
    final newPages = Map<int, PageContentDto>.from(s.pages);

    // Get previous + next partition IDs
    final prevId = event.partitionId - 1;
    final nextId = event.partitionId + 1;
    final maxId = snapshotService.getTotalByMode(snapshot, s.partitionMode);

    final neighborIds = <int>[];
    if (prevId >= 1) neighborIds.add(prevId);
    if (nextId <= maxId) neighborIds.add(nextId);

    // Prefetch only the first page of each neighbor partition
    for (final pid in neighborIds) {
      final neighborPages = snapshot.pagesByMode(s.partitionMode, pid);
      if (neighborPages.isNotEmpty) {
        final firstPage = neighborPages.first;
        if (!newPages.containsKey(firstPage)) {
          try {
            final dto = await pageDataSource.getPageContent(firstPage);
            newPages[firstPage] = dto;
          } catch (e, st) {
            Debugger.red("Failed prefetch partition $pid first page: $e");
            Debugger.red(st);
          }
        }
      }
    }

    emit(s.copyWith(pages: newPages));
  }
}
