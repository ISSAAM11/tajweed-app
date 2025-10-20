part of '../quran_page_bloc.dart';

extension QuranPageUc on QuranPageBloc {
  Future<void> _onInitToVerse(
    InitToVerse event,
    Emitter<QuranPageState> emit,
  ) async {
    final snapshot = snapshotService.snapshot;
    final totalPartitions = snapshotService.getTotalByMode(
      snapshot,
      event.mode,
    );
    // 1. Resolve the page containing the verse
    final pageNo = await pageDataSource.getPageForVerse(event.verseKey);

    // 1. get surah arabic Name
    final chap = await pageDataSource.getChapterHeader(event.verseKey.surah);
    // 2. Find the partition that contains this page
    final partitionId = snapshot.pageToPartition(event.mode, pageNo);

    // 3. Get all pages for this partition
    final partitionPages = snapshot.pagesByMode(event.mode, partitionId);

    // 4. Compute the vertical index inside the partition
    final initialIndex = partitionPages.indexOf(pageNo);

    // 5. Emit loaded state with the index hint for UI
    emit(
      QuranPageLoaded(
        surahName: chap.nameArabic,
        partitionMode: event.mode,
        partitionId: partitionId,
        currentPartitionPages: partitionPages,
        totalPartitions: totalPartitions,
        pages: state.pages,
        loadingPages: state.loadingPages,
        initialPageIndex: (initialIndex >= 0) ? initialIndex : 0,
      ),
    );

    // 6. Prefetch the current page
    add(PrefetchPages([pageNo]));
  }

  Future<void> _onChangePartitionMode(
    ChangePartitionMode event,
    Emitter<QuranPageState> emit,
  ) async {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final snapshot = snapshotService.snapshot;
    final newMode = event.newMode;
    final totalPartitions = snapshotService.getTotalByMode(snapshot, newMode);

    // 1. Use the page passed by the UI as the current visible page
    final currentPageNo = event.currentPageNo;

    // 2. Find the new partition containing this page
    final newPartitionId = snapshot.pageToPartition(newMode, currentPageNo);

    // 3. Get all pages of that partition
    final newPartitionPages = snapshot.pagesByMode(newMode, newPartitionId);

    // 4. Find the index of the current page within new partition
    final newIndex = newPartitionPages.indexOf(currentPageNo);
    final safeIndex = (newIndex >= 0) ? newIndex : 0;

    // 5. Emit updated state with initial page index for UI
    emit(
      s.copyWith(
        partitionMode: newMode,
        partitionId: newPartitionId,
        currentPartitionPages: newPartitionPages,
        totalPartitions: totalPartitions,
        initialPageIndex: safeIndex,
      ),
    );

    // 6. Prefetch the visible page
    if (newPartitionPages.isNotEmpty) {
      add(PrefetchPages([newPartitionPages[safeIndex]]));
    }
  }

  void _onPartitionScrollUpdated(
    PartitionScrollUpdated event,
    Emitter<QuranPageState> emit,
  ) {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final pages = s.currentPartitionPages;
    final total = pages.length;
    final idx = event.pageIndex;

    // Always prefetch around current index (±2 for example)
    const radius = 2;
    final start = (idx - radius).clamp(0, total);
    final end = (idx + radius + 1).clamp(0, total);

    final toPrefetch = pages.sublist(start, end);
    if (toPrefetch.isNotEmpty) {
      add(PrefetchPages(toPrefetch));
    }
  }

  Future<void> _onPartitionChanged(
    PartitionChanged event,
    Emitter<QuranPageState> emit,
  ) async {
    final newPartitionId = event.newPartitionId;
    // Get first page to retrieve surah name
    final newPages = snapshotService.snapshot.pagesByMode(
      event.partitionMode,
      event.newPartitionId,
    );
    // retrieve surah name
    final chap = await pageDataSource.getChapterHeader(newPages.first);

    emit(
      state.copyWith(surahName: chap.nameArabic, partitionId: newPartitionId),
    );
  }

  Future<void> _onfetchPartitionContent(
    FetchPartitionContent event,
    Emitter<QuranPageState> emit,
  ) async {
    final newPages = snapshotService.snapshot.pagesByMode(
      event.partitionMode,
      event.newPartitionId,
    );

    emit(
      state.copyWith(
        partitionId: event.newPartitionId,
        currentPartitionPages: newPages,
      ),
    );

    add(PrefetchPages(newPages));
  }
}
