part of '../quran_page_bloc.dart';

extension QuranPageUc on QuranPageBloc {
  Future<void> _onInitToVerse(
    InitToVerse event,
    Emitter<QuranPageState> emit,
  ) async {
    final snapshot = snapshotService.snapshot;
    final totalPartitions = snapshotService.getTotalByMode(snapshot);
    // 1. Resolve the page containing the verse
    final pageNo = await pageDataSource.getPageForVerse(event.verseKey);

    // 2. Get surah arabic name
    final chap = await pageDataSource.getChapterHeader(pageNo);

    // 3. Find the partition that contains this page
    final partitionId = snapshot.pageToPartition(pageNo);

    // 4. Emit loaded state
    emit(
      QuranPageLoaded(
        surahName: chap.nameArabic,
        surahNameSimple: chap.nameSimple,
        partitionMode: PartitionMode.page,
        partitionId: partitionId,
        currentPage: pageNo,
        totalPartitions: totalPartitions,
        page: state.page,
        loadingPages: state.loadingPages,
        initialPageIndex: 0,
      ),
    );

    // 5. Prefetch the current page
    add(PrefetchPages(pageNo));
  }

  Future<void> _onChangePartitionMode(
    ChangePartitionMode event,
    Emitter<QuranPageState> emit,
  ) async {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final snapshot = snapshotService.snapshot;
    final newMode = event.newMode;
    final totalPartitions = snapshotService.getTotalByMode(snapshot);

    // 1. Use the page passed by the UI as the current visible page
    final currentPageNo = event.currentPageNo;

    // 2. Find the new partition containing this page
    final newPartitionId = snapshot.pageToPartition(currentPageNo);

    // 3. Emit updated state
    emit(
      s.copyWith(
        partitionMode: newMode,
        partitionId: newPartitionId,
        currentPage: currentPageNo,
        totalPartitions: totalPartitions,
        initialPageIndex: 0,
      ),
    );

    // 4. Prefetch the visible page
    add(PrefetchPages(currentPageNo));
  }

  void _onPartitionScrollUpdated(
    PartitionScrollUpdated event,
    Emitter<QuranPageState> emit,
  ) {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final currentPage = s.currentPage;

    // Prefetch current page and neighbors (±2 pages)
    const radius = 2;
    final pagesToPrefetch = List.generate(
      radius * 2 + 1,
      (i) => currentPage - radius + i,
    ).where((p) => p >= 1 && p <= 604); // Valid Quran page range

    for (final page in pagesToPrefetch) {
      add(PrefetchPages(page));
    }
  }

  Future<void> _onPartitionChanged(
    PartitionChanged event,
    Emitter<QuranPageState> emit,
  ) async {
    final newPartitionId = event.newPartitionId;
    // Get first page to retrieve surah name
    final newPage = snapshotService.snapshot.pageByMode(event.newPartitionId);
    // retrieve surah name

    final chap = await pageDataSource.getChapterHeader(newPage);

    emit(
      state.copyWith(
        surahName: chap.nameArabic,
        surahNameSimple: chap.nameSimple,
        partitionId: newPartitionId,
      ),
    );
  }

  Future<void> _onfetchPartitionContent(
    FetchPartitionContent event,
    Emitter<QuranPageState> emit,
  ) async {
    final newPage = snapshotService.snapshot.pageByMode(event.newPartitionId);
    VerseKey verseKey = await pageDataSource.getVersesForPage(newPage);

    final lastSurahService = get<LastSelectedSurahService>();
    final datasource = get<QuranListingDatasource>();
    final chapter = await datasource.getChapterById(verseKey.surah);

    LastSelectedPage lastSelectedPage = LastSelectedPage(
      name: chapter!.nameSimple,
      nameArabic: chapter.nameArabic,
      pageNumber: newPage,
      verseKey: verseKey,
    );

    await lastSurahService.set(lastSelectedPage);

    emit(
      state.copyWith(partitionId: event.newPartitionId, currentPage: newPage),
    );

    add(PrefetchPages(newPage));
  }
}
