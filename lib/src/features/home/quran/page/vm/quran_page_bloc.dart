import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/cache/listing_cache.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/datasource/quran_listing_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/quran_page_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/page/services/partition_snapshot_service.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_events.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_state.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

part 'usecases/quran_page_prefetch_uc.dart';
part 'usecases/quran_page_uc.dart';

class QuranPageBloc extends BaseBloc<QuranPageEvent, QuranPageState> {
  final QuranPageDatasource pageDataSource;
  final PartitionSnapshotService snapshotService;
  void initToVerse(VerseKey verse) => add(InitToVerse(verse));

  void prefetchPages(int pageToPrefetch) => add(PrefetchPages(pageToPrefetch));

  void partitionChanged(int newPartition) =>
      add(PartitionChanged(newPartition));

  void fetchPartitionContent(int newPartition) =>
      add(FetchPartitionContent(newPartition));

  void prefetchNeighborPartitions(PartitionMode mode, int newPartitionId) =>
      add(PrefetchNeighborPartitions(newPartitionId));

  void partitionScrollUpdated({
    required int partitionId,
    required int pageIndex,
    required ScrollDirection direction,
  }) => (add(
    PartitionScrollUpdated(
      partitionId: partitionId,
      pageIndex: pageIndex,
      direction: direction,
    ),
  ));

  QuranPageBloc(this.pageDataSource, this.snapshotService)
    : super(QuranPageInitial(), debugginEnabled: true) {
    on<InitToVerse>(_onInitToVerse);
    on<ChangePartitionMode>(_onChangePartitionMode);

    on<PartitionChanged>(_onPartitionChanged);
    on<FetchPartitionContent>(_onfetchPartitionContent);
    on<PrefetchPages>(_onPrefetchPages);

    on<PrefetchNeighborPartitions>(_prefetchNeighborPartitions);
    on<PartitionScrollUpdated>(_onPartitionScrollUpdated);
  }

  @override
  void onInit() {
    Debugger.green('init QuranPageBloc');
    if (state is InitToVerse) super.onInit();
  }
}
