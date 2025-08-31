part of '../quran_page/quran_page_bloc.dart';

extension QuranListingUC on QuranPageBloc {
  Future<void> _onInitToVerse(
    InitToVerse event,
    Emitter<QuranPageState> emit,
  ) async {
    final snapshot = snapshotService.snapshot;

    // find pageNo of verse
    final pageNo = await pageDataSource.getPageForVerse(event.verseKey);
    final partitionId = snapshot.pageToPartition(event.mode, pageNo);
    final partitionPages = snapshot.pagesByMode(event.mode, partitionId);

    final verticalIndex = partitionPages.indexOf(pageNo);
    emit(
      QuranPageLoaded(
        partitionMode: event.mode,
        partitionId: partitionId,
        currentPartitionPages: partitionPages,
        pages: {},
        verticalIndex: verticalIndex,
        loadingPages: {},
        pageController: state.pageController,
        verticalController: state.verticalController,
      ),
    );
    // 4. Jump controllers
    state.pageController.jumpToPage(partitionId); // horizontal
    state.verticalController.jumpTo(index: state.verticalIndex); // vertical

    // 5. Prefetch page content
    add(PrefetchPages([pageNo]));
  }

  Future<void> _onChangePartitionMode(
    ChangePartitionMode event,
    Emitter<QuranPageState> emit,
  ) async {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final pageNo = s.currentPartitionPages[s.verticalIndex];
    final snapshot = snapshotService.snapshot;

    final partitionId = snapshot.pageToPartition(event.newMode, pageNo);
    final partitionPages = snapshot.pagesByMode(event.newMode, partitionId);
    final verticalIndex = partitionPages.indexOf(pageNo);
    emit(
      s.copyWith(
        partitionMode: event.newMode,
        partitionId: partitionId,
        currentPartitionPages: partitionPages,
        verticalIndex: verticalIndex,
      ),
    );
    prefetchPages([pageNo]);
  }

  void _onVerticalIndexChanged(
    VerticalIndexChanged event,
    Emitter<QuranPageState> emit,
  ) {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;
    emit(s.copyWith(verticalIndex: event.newIndex));

    // trigger prefetch if close to edges
    final remaining = s.currentPartitionPages.length - event.newIndex;
    if (remaining <= 2) {
      final toPrefetch = s.currentPartitionPages
          .skip(event.newIndex + 1)
          .take(2)
          .toList();
      prefetchPages(toPrefetch);
    }
  }

  Future<void> _onHorizontalIndexChanged(
    HorizontalIndexChanged event,
    Emitter<QuranPageState> emit,
  ) async {
    final newPartitionId = event.newPartitionId;

    // Get pages for this partition
    final newPages = snapshotService.snapshot.pagesByMode(
      state.partitionMode,
      newPartitionId,
    );

    emit(
      state.copyWith(
        partitionId: newPartitionId,
        currentPartitionPages: newPages,
        verticalIndex: 0, // reset to top of new partition
      ),
    );

    // Jump vertical controller to top
    state.verticalController.jumpTo(index: 0);

    // Prefetch first page(s) if needed
    if (newPages.isNotEmpty) {
      prefetchPages([newPages.first]);
    }
  }

  Future<void> _onPrefetchPages(
    PrefetchPages event,
    Emitter<QuranPageState> emit,
  ) async {
    if (state is! QuranPageLoaded) return;
    final s = state as QuranPageLoaded;

    final stillNeeded = event.pageNos
        .where((p) => !s.pages.containsKey(p) && !s.loadingPages.contains(p))
        .toList();
    if (stillNeeded.isEmpty) return;

    emit(s.copyWith(loadingPages: {...s.loadingPages, ...stillNeeded}));

    for (final pageNo in stillNeeded) {
      try {
        final page = await pageDataSource.getPageContent(pageNo);
        final filtered = pageDataSource.applyPipeline(s.partitionMode, page);
        final newPages = Map<int, PageContentDto>.from(s.pages)
          ..[pageNo] = filtered;
        emit(
          s.copyWith(
            pages: newPages,
            loadingPages: s.loadingPages.difference({pageNo}),
          ),
        );
      } catch (e) {
        // Optionally handle errors per page
        emit(s.copyWith(loadingPages: s.loadingPages.difference({pageNo})));
      }
    }
  }
}
