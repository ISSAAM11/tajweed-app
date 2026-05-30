part of '../audio_player_bloc.dart';

extension AudioPlayerUc on AudioPlayerBloc {
  // ── Request handlers ──────────────────────────────────────────────

  Future<void> _onRequestPlay(
    AudioPlayerEvent event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final pending = switch (event) {
      RequestPlayAyah(:final surah, :final ayah) => PendingRequest(
          surah: surah,
          ayah: ayah,
          mode: PlaybackMode.single,
        ),
      RequestPlayPage(:final ayahs) => PendingRequest(
          surah: ayahs.first.surah,
          ayah: ayahs.first.ayah,
          mode: PlaybackMode.page,
          pageAyahs: ayahs,
        ),
      RequestPlaySurah(:final surah, :final startFromAyah) => PendingRequest(
          surah: surah,
          ayah: startFromAyah,
          mode: PlaybackMode.surah,
        ),
      _ => null,
    };
    if (pending == null) return;

    final cheikh = _cheikh.state;

    final surahs = <int>{pending.surah};
    if (pending.pageAyahs != null) {
      for (final v in pending.pageAyahs!) surahs.add(v.surah);
    }

    final missing = <int>[];
    for (final s in surahs) {
      if (!await _downloader.isSurahDownloaded(cheikh, s)) missing.add(s);
    }

    if (missing.isEmpty) {
      await _startPlayback(pending, emit);
    } else {
      emit(AudioAwaitingDownload(pending));
    }
  }

  Future<void> _onConfirmDownload(
    ConfirmDownload event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final current = state;
    if (current is! AudioAwaitingDownload) return;
    final pending = current.pending;

    final cheikh = _cheikh.state;

    final surahs = <int>{pending.surah};
    if (pending.pageAyahs != null) {
      for (final v in pending.pageAyahs!) surahs.add(v.surah);
    }

    final toDownload = <int>[];
    for (final s in surahs) {
      if (!await _downloader.isSurahDownloaded(cheikh, s)) toDownload.add(s);
    }

    try {
      final total = toDownload.length;
      for (int i = 0; i < toDownload.length; i++) {
        final surah = toDownload[i];

        if (cheikh.audioType == CheikhAudioType.ayahLevel) {
          final ayahUrls = await _dao.getAyahAudioUrlsForSurah(cheikh, surah);
          if (ayahUrls.isEmpty) {
            emit(const AudioError('audioDownloadError'));
            return;
          }
          await _downloader.downloadAyahs(
            ayahUrls,
            cheikh,
            surah,
            onProgress: (p) => emit(AudioDownloading((i + p) / total)),
          );
        } else {
          final url = await _dao.getSurahAudioUrl(cheikh, surah);
          if (url == null) {
            emit(const AudioError('audioDownloadError'));
            return;
          }
          await _downloader.downloadSurah(
            url,
            cheikh,
            surah,
            onProgress: (p) => emit(AudioDownloading((i + p) / total)),
          );
        }
      }
    } catch (_) {
      emit(const AudioError('audioDownloadError'));
      return;
    }

    await _startPlayback(pending, emit);
  }

  Future<void> _onCancelDownload(
    CancelDownload event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(const AudioIdle());
  }

  // ── Playback controls ─────────────────────────────────────────────

  Future<void> _onPause(PauseAudio _, Emitter<AudioPlayerState> emit) async {
    final s = state;
    if (s is! AudioPlaying) return;
    await _player.pause();
    emit(AudioPaused(
      surah: s.surah,
      currentAyah: s.currentAyah,
      mode: s.mode,
      currentIndex: s.currentIndex,
      totalInQueue: s.totalInQueue,
    ));
  }

  Future<void> _onResume(ResumeAudio _, Emitter<AudioPlayerState> emit) async {
    final s = state;
    if (s is! AudioPaused) return;
    _player.resume();
    emit(AudioPlaying(
      surah: s.surah,
      currentAyah: s.currentAyah,
      mode: s.mode,
      currentIndex: s.currentIndex,
      totalInQueue: s.totalInQueue,
    ));
  }

  Future<void> _onStop(StopAudio _, Emitter<AudioPlayerState> emit) async {
    await _indexSub?.cancel();
    _indexSub = null;
    await _player.stop();
    emit(const AudioIdle());
  }

  Future<void> _onSkipNext(SkipNext _, Emitter<AudioPlayerState> emit) async {
    await _player.skipNext();
  }

  Future<void> _onSkipPrevious(
    SkipPrevious _,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _player.skipPrevious();
  }

  Future<void> _onIndexAdvanced(
    _IndexAdvanced event,
    Emitter<AudioPlayerState> emit,
  ) async {
    final s = state;
    if (s is AudioPlaying) {
      emit(s.copyWithIndex(event.newIndex, event.queue));
    }
  }

  Future<void> _onPlaybackCompleted(
    _PlaybackCompleted _,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _indexSub?.cancel();
    _indexSub = null;
    emit(const AudioIdle());
  }

  Future<void> _onPlaybackError(
    _PlaybackError _,
    Emitter<AudioPlayerState> emit,
  ) async {
    await _indexSub?.cancel();
    _indexSub = null;
    // Reset the player to idle so the next play attempt starts clean.
    await _player.stop().catchError((_) {});
    emit(const AudioIdle());
  }

  // ── Internal: start playback ──────────────────────────────────────

  Future<void> _startPlayback(
    PendingRequest pending,
    Emitter<AudioPlayerState> emit,
  ) async {
    try {
      final cheikh = _cheikh.state;
      final List<AyahSegment> queue;
      int startIndex = 0;

      switch (pending.mode) {
        case PlaybackMode.single:
          final seg =
              await _dao.getAyahSegment(cheikh, pending.surah, pending.ayah);
          if (seg == null) {
            emit(const AudioError('audioSegmentNotFound'));
            return;
          }
          queue = [seg];

        case PlaybackMode.page:
          queue = await _dao.getAyahsSegments(cheikh, pending.pageAyahs!);
          if (queue.isEmpty) {
            emit(const AudioError('audioSegmentNotFound'));
            return;
          }

        case PlaybackMode.surah:
          queue = await _dao.getSurahSegments(cheikh, pending.surah);
          if (queue.isEmpty) {
            emit(const AudioError('audioSegmentNotFound'));
            return;
          }
          startIndex = queue.indexWhere((s) => s.ayah == pending.ayah);
          if (startIndex < 0) startIndex = 0;
      }

      // Build one file path per queue entry.
      final List<String> filePaths;
      if (cheikh.audioType == CheikhAudioType.ayahLevel) {
        filePaths = await Future.wait(
          queue.map(
            (seg) => _downloader
                .getAyahFile(cheikh, seg.surah, seg.ayah)
                .then((f) => f.path),
          ),
        );
      } else {
        final surahsInQueue = queue.map((s) => s.surah).toSet();
        final fileMap = <int, String>{};
        for (final s in surahsInQueue) {
          fileMap[s] = (await _downloader.getLocalFile(cheikh, s)).path;
        }
        filePaths = queue.map((s) => fileMap[s.surah]!).toList();
      }

      _subscribeToIndex(queue);
      await _player.playQueue(queue, filePaths, startIndex: startIndex);

      final first = queue[startIndex];
      emit(AudioPlaying(
        surah: first.surah,
        currentAyah: first.ayah,
        mode: pending.mode,
        currentIndex: startIndex,
        totalInQueue: queue.length,
      ));
    } catch (e) {
      emit(const AudioError('audioPlaybackError'));
    }
  }
}
