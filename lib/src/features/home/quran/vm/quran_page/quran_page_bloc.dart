import 'package:tajweed_ai/src/base/bloc/exports.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/page_models.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/partition_snapshot_service.dart';
import 'package:tajweed_ai/src/features/home/quran/datasource/page/quran_page_datasource.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_events.dart';
import 'package:tajweed_ai/src/features/home/quran/vm/quran_page/quran_page_state.dart';

part '../usecases/quran_page_uc.dart';

class QuranPageBloc extends BaseBloc<QuranPageEvent, QuranPageState> {
  final QuranPageDatasource pageDataSource;
  final PartitionSnapshotService snapshotService;

  void prefetchPages(List<int> pagesToPrefetch) => {
    add(PrefetchPages(pagesToPrefetch)),
  };
  void horizontalIndexChanged(int newPartition) => {
    add(HorizontalIndexChanged(newPartition)),
  };
  void verticalIndexChanged(int newIndex) => {
    add(VerticalIndexChanged(newIndex)),
  };
  void initToVerse(VerseKey verse, PartitionMode mode) => {
    add(InitToVerse(verse, mode)),
  };

  QuranPageBloc(this.pageDataSource, this.snapshotService)
    : super(QuranPageInitial(), debugginEnabled: true) {
    on<InitToVerse>(_onInitToVerse);
    on<ChangePartitionMode>(_onChangePartitionMode);
    on<VerticalIndexChanged>(_onVerticalIndexChanged);
    on<HorizontalIndexChanged>(_onHorizontalIndexChanged);
    on<PrefetchPages>(_onPrefetchPages);
  }

  @override
  void onInit() {
    Debugger.green('init QuranPageBloc');
    if (state is InitToVerse) super.onInit();
  }

  @override
  Future<void> close() {
    state.pageController.dispose();
    state.verticalController;
    return super.close();
  }
}
