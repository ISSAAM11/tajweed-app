import 'package:tajweed_ai/src/base/dependencies/dependencies.dart';
import 'package:tajweed_ai/src/base/datasource/exports.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/database/daos/quran_page_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/audio_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/audio_download_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/quran_audio_player_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/vm/hifth_bloc.dart';

class HifthDependencies implements Dependencies {
  @override
  void inject() {
    // Audio services — shared with the quran page feature; registration is
    // idempotent, whichever screen opens first wins.
    di.registerLazySingleton<AudioDownloadService>(
      () => AudioDownloadService(get<Dio>(), get<ConnectivityMonitor>()),
    );
    di.registerLazySingleton<QuranAudioPlayerService>(
      () => QuranAudioPlayerService(),
    );
    di.registerFactory<AudioPlayerBloc>(
      () => AudioPlayerBloc(
        dao: get<AudioDao>(),
        downloader: get<AudioDownloadService>(),
        player: get<QuranAudioPlayerService>(),
        cheikh: get<CheikhCubit>(),
      ),
    );

    di.registerFactory<HifthBloc>(() => HifthBloc(get<QuranPageDao>()));
  }
}
