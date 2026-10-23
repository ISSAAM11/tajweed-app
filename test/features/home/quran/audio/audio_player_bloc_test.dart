import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/database/audio_dao.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/ayah_segment.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/audio_download_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/cheikh_preference_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/quran_audio_player_service.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';

class _MockDao extends Mock implements AudioDao {}

class _MockDownloader extends Mock implements AudioDownloadService {}

class _MockPlayer extends Mock implements QuranAudioPlayerService {}

const _testCheikh = CheikhReciter(
  id: 'ahmad-alnufais',
  name: 'Ahmad Al-Nufais',
  nameArabic: 'أحمد النفيس',
  dbAssetPath: 'assets/db/surah-recitation-ahmad-alnufais.db',
);

const _seg1 = AyahSegment(surah: 1, ayah: 1, timestampFrom: 0, timestampTo: 5000);
const _seg2 = AyahSegment(surah: 1, ayah: 2, timestampFrom: 5000, timestampTo: 9000);
const _seg3 = AyahSegment(surah: 1, ayah: 3, timestampFrom: 9000, timestampTo: 14000);
final _fakeFile = File('/fake/1.mp3');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    registerFallbackValue(<AyahSegment>[]);
    registerFallbackValue(<int, String>{});
    registerFallbackValue(_testCheikh);
  });

  late _MockDao dao;
  late _MockDownloader downloader;
  late _MockPlayer player;
  late CheikhCubit cheikhCubit;
  late StreamController<PlayerState> playerStateCtrl;
  late StreamController<int?> indexCtrl;
  late AudioPlayerBloc bloc;

  setUp(() {
    dao = _MockDao();
    downloader = _MockDownloader();
    player = _MockPlayer();

    playerStateCtrl = StreamController<PlayerState>.broadcast();
    indexCtrl = StreamController<int?>.broadcast();

    when(() => player.playerStateStream).thenAnswer((_) => playerStateCtrl.stream);
    when(() => player.currentIndexStream).thenAnswer((_) => indexCtrl.stream);
    when(() => player.playerErrorStream).thenAnswer((_) => const Stream.empty());
    when(() => player.dispose()).thenAnswer((_) async {});

    // Real CheikhCubit with the test cheikh — no platform calls needed
    cheikhCubit = CheikhCubit(
      _FakeCheikhPrefs(),
      [_testCheikh],
      _testCheikh.id,
    );

    bloc = AudioPlayerBloc(
      dao: dao,
      downloader: downloader,
      player: player,
      cheikh: cheikhCubit,
    );
  });

  tearDown(() async {
    await bloc.close();
    await cheikhCubit.close();
    await playerStateCtrl.close();
    await indexCtrl.close();
  });

  // ── Helpers ──────────────────────────────────────────────────────────────

  void stubDownloaded(int surah, {bool downloaded = true}) =>
      when(() => downloader.isSurahDownloaded(any(), surah))
          .thenAnswer((_) async => downloaded);

  void stubPlayQueue() =>
      when(() => player.playQueue(any(), any(), startIndex: any(named: 'startIndex')))
          .thenAnswer((_) async {});

  Future<void> reachPlayingState({int surah = 1, int ayah = 1}) async {
    stubDownloaded(surah);
    when(() => dao.getAyahSegment(any(), surah, ayah))
        .thenAnswer((_) async => _seg1);
    when(() => downloader.getLocalFile(any(), surah))
        .thenAnswer((_) async => _fakeFile);
    stubPlayQueue();

    bloc.add(RequestPlayAyah(surah, ayah));
    await pumpEventQueue();
    expect(bloc.state, isA<AudioPlaying>());
  }

  // ── Tests ─────────────────────────────────────────────────────────────────

  group('AudioPlayerBloc', () {
    test('initial state is AudioIdle', () {
      expect(bloc.state, isA<AudioIdle>());
    });

    group('RequestPlayAyah', () {
      test('emits AudioPlaying when surah is already downloaded', () async {
        stubDownloaded(1);
        when(() => dao.getAyahSegment(any(), 1, 1))
            .thenAnswer((_) async => _seg1);
        when(() => downloader.getLocalFile(any(), 1))
            .thenAnswer((_) async => _fakeFile);
        stubPlayQueue();

        final future = expectLater(
          bloc.stream,
          emits(
            isA<AudioPlaying>()
                .having((s) => s.surah, 'surah', 1)
                .having((s) => s.currentAyah, 'currentAyah', 1)
                .having((s) => s.mode, 'mode', PlaybackMode.single)
                .having((s) => s.totalInQueue, 'totalInQueue', 1),
          ),
        );

        bloc.add(const RequestPlayAyah(1, 1));
        await future;
      });

      test('emits AudioAwaitingDownload when surah file is missing', () async {
        stubDownloaded(1, downloaded: false);

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioAwaitingDownload>()),
        );

        bloc.add(const RequestPlayAyah(1, 1));
        await future;
      });

      test('emits AudioError when DAO returns null segment', () async {
        stubDownloaded(1);
        when(() => dao.getAyahSegment(any(), 1, 1))
            .thenAnswer((_) async => null);
        when(() => downloader.getLocalFile(any(), 1))
            .thenAnswer((_) async => _fakeFile);

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioError>()),
        );

        bloc.add(const RequestPlayAyah(1, 1));
        await future;
      });
    });

    group('RequestPlaySurah', () {
      test('emits AudioPlaying at the correct start ayah', () async {
        stubDownloaded(1);
        when(() => dao.getSurahSegments(any(), 1))
            .thenAnswer((_) async => [_seg1, _seg2, _seg3]);
        when(() => downloader.getLocalFile(any(), 1))
            .thenAnswer((_) async => _fakeFile);
        stubPlayQueue();

        final future = expectLater(
          bloc.stream,
          emits(
            isA<AudioPlaying>()
                .having((s) => s.currentAyah, 'currentAyah', 2)
                .having((s) => s.currentIndex, 'currentIndex', 1)
                .having((s) => s.totalInQueue, 'totalInQueue', 3)
                .having((s) => s.mode, 'mode', PlaybackMode.surah),
          ),
        );

        bloc.add(const RequestPlaySurah(1, 2));
        await future;

        verify(() => player.playQueue(any(), any(), startIndex: 1)).called(1);
      });
    });

    group('CancelDownload', () {
      test('emits AudioIdle', () async {
        stubDownloaded(1, downloaded: false);

        bloc.add(const RequestPlayAyah(1, 1));
        await pumpEventQueue();
        expect(bloc.state, isA<AudioAwaitingDownload>());

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioIdle>()),
        );

        bloc.add(const CancelDownload());
        await future;
      });
    });

    group('ConfirmDownload', () {
      test('downloads and emits AudioPlaying', () async {
        stubDownloaded(1, downloaded: false);
        when(() => dao.getSurahAudioUrl(any(), 1))
            .thenAnswer((_) async => 'https://example.com/1.mp3');
        when(() => downloader.downloadSurah(
              any(),
              any(),
              any(),
              onProgress: any(named: 'onProgress'),
            )).thenAnswer((_) async => _fakeFile);
        when(() => dao.getAyahSegment(any(), 1, 1))
            .thenAnswer((_) async => _seg1);
        when(() => downloader.getLocalFile(any(), 1))
            .thenAnswer((_) async => _fakeFile);
        stubPlayQueue();

        bloc.add(const RequestPlayAyah(1, 1));
        await pumpEventQueue();
        expect(bloc.state, isA<AudioAwaitingDownload>());

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioPlaying>()),
        );

        bloc.add(const ConfirmDownload());
        await future;

        verify(() => downloader.downloadSurah(
              'https://example.com/1.mp3',
              any(),
              1,
              onProgress: any(named: 'onProgress'),
            )).called(1);
      });

      test('emits AudioError when the audio URL is unavailable', () async {
        stubDownloaded(1, downloaded: false);
        when(() => dao.getSurahAudioUrl(any(), 1))
            .thenAnswer((_) async => null);

        bloc.add(const RequestPlayAyah(1, 1));
        await pumpEventQueue();
        expect(bloc.state, isA<AudioAwaitingDownload>());

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioError>()),
        );

        bloc.add(const ConfirmDownload());
        await future;
      });
    });

    group('PauseAudio / ResumeAudio', () {
      test('PauseAudio transitions AudioPlaying → AudioPaused', () async {
        await reachPlayingState();

        when(() => player.pause()).thenAnswer((_) async {});

        final future = expectLater(
          bloc.stream,
          emits(
            isA<AudioPaused>()
                .having((s) => s.currentAyah, 'currentAyah', 1)
                .having((s) => s.surah, 'surah', 1),
          ),
        );

        bloc.add(const PauseAudio());
        await future;
      });

      test('ResumeAudio transitions AudioPaused → AudioPlaying', () async {
        await reachPlayingState();

        when(() => player.pause()).thenAnswer((_) async {});
        when(() => player.resume()).thenReturn(null);

        bloc.add(const PauseAudio());
        await pumpEventQueue();
        expect(bloc.state, isA<AudioPaused>());

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioPlaying>()),
        );

        bloc.add(const ResumeAudio());
        await future;
      });
    });

    group('StopAudio', () {
      test('emits AudioIdle from AudioPlaying', () async {
        await reachPlayingState();

        when(() => player.stop()).thenAnswer((_) async {});

        final future = expectLater(
          bloc.stream,
          emits(isA<AudioIdle>()),
        );

        bloc.add(const StopAudio());
        await future;
      });
    });
  });
}

// Minimal in-memory preference stub — no platform calls needed in tests.
class _FakeCheikhPrefs extends Fake implements CheikhPreferenceService {
  String _id = 'ahmad-alnufais';

  @override
  String get() => _id;

  @override
  Future<void> set(String cheikhId) async => _id = cheikhId;
}
