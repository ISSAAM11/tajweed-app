import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/quran_page_datasource.dart';

class QuranPrefetchHelper {
  final QuranPageDatasource pageDatasource;

  QuranPrefetchHelper(this.pageDatasource);

  /// Prefetch pages around a single page (vertical prefetch)
  Future<void> prefetchPagesAround(
    int centerPage, {
    int before = 2,
    int after = 2,
  }) async {
    final futures = <Future>[];
    for (int p = centerPage - before; p <= centerPage + after; p++) {
      if (p <= 0) continue;
      futures.add(pageDatasource.getPageContent(p));
    }
    await Future.wait(futures);
  }

  /// Prefetch the first pages of neighbor partitions (horizontal prefetch)
  Future<void> prefetchNeighborFirstPages(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
    int neighborPartitions = 1,
  }) async {
    for (int i = 1; i <= neighborPartitions; i++) {
      final prev = partitionNo - i;
      final next = partitionNo + i;

      if (prev > 0) {
        final prevPages = await pageDatasource.dao.getPagesForPartition(
          mode,
          prev,
          fraction: fraction,
        );
        if (prevPages.isNotEmpty) {
          await pageDatasource.getPageContent(prevPages.first);
        }
      }

      final nextPages = await pageDatasource.dao.getPagesForPartition(
        mode,
        next,
        fraction: fraction,
      );
      if (nextPages.isNotEmpty) {
        await pageDatasource.getPageContent(nextPages.first);
      }
    }
  }

  /// Prefetch full vertical + neighbor first pages in parallel
  Future<void> prefetchPartitionWithNeighbors(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
    int neighborPartitions = 1,
  }) async {
    final currentPages = await pageDatasource.dao.getPagesForPartition(
      mode,
      partitionNo,
      fraction: fraction,
    );

    // Vertical prefetch for current partition
    final verticalFutures = <Future>[];
    for (final p in currentPages) {
      verticalFutures.add(prefetchPagesAround(p));
    }

    // Horizontal prefetch for neighboring partitions
    final horizontalFuture = prefetchNeighborFirstPages(
      mode,
      partitionNo,
      fraction: fraction,
      neighborPartitions: neighborPartitions,
    );

    await Future.wait([...verticalFutures, horizontalFuture]);
  }

  /// Stream pages of current partition with neighbor prefetch
  Stream<List<PageContentDto>> watchPartitionWithPrefetch(
    PartitionMode mode,
    int partitionNo, {
    HizbFraction? fraction,
    int neighborPartitions = 1,
  }) async* {
    // Prefetch in background
    prefetchPartitionWithNeighbors(
      mode,
      partitionNo,
      fraction: fraction,
      neighborPartitions: neighborPartitions,
    );

    // Reactive stream for current partition pages
    await for (final pages in pageDatasource.watchPartition(
      mode,
      partitionNo,
      fraction: fraction,
    )) {
      yield pages;
    }
  }
}





// *************** example usage 
// StreamBuilder<List<PageContentDto>>(
//   stream: prefetchHelper.watchPartitionWithPrefetch(
//       PartitionMode.juz, 3,
//       neighborPartitions: 1),
//   builder: (context, snapshot) {
//     final pages = snapshot.data ?? [];
//     return PageView.builder(
//       scrollDirection: Axis.vertical,
//       itemCount: pages.length,
//       itemBuilder: (_, index) => QuranPageWidget(content: pages[index]),
//     );
//   },
// );