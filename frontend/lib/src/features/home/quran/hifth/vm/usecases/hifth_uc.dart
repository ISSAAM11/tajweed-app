part of '../hifth_bloc.dart';

extension HifthUc on HifthBloc {
  Future<void> _onLoadSurah(LoadSurah event, Emitter<HifthState> emit) async {
    emit(const HifthLoading());
    try {
      final header = await _dao.getSurahName(event.surah);
      final rows = await _dao.getSurahPlainWords(event.surah);

      // Rows arrive in mushaf order (ayah asc, word asc). `text` carries mushaf
      // font codes in the Private Use Area — a trailing ornament on some real
      // words, and the whole verse-end marker. Strip those, then keep only what
      // still holds an Arabic letter, which drops the marker rows. Same
      // treatment as copying an ayah on the Quran page
      // (`_PageViewerState._getAyahText`).
      //
      // The surviving text is IndoPak-encoded while this screen renders it in
      // Uthmanic Hafs, so it also needs converting — otherwise every Yeh paints
      // as a placeholder blob.
      final wordsByAyah = <int, List<String>>{};
      for (final row in rows) {
        final text = QuranTextParser.stripGlyphSigns(row.text);
        if (!arabicLetter.hasMatch(text)) continue;
        wordsByAyah
            .putIfAbsent(row.ayah, () => [])
            .add(QuranTextParser.toUthmanicScript(text));
      }

      final ayahs = [
        for (final entry in wordsByAyah.entries)
          HifthAyah(number: entry.key, text: entry.value.join(' ')),
      ];

      emit(HifthLoaded(header: header, ayahs: ayahs));

      // Opening a surah only moves the bookmark when it is a different surah.
      // Coming back to the one you were memorising must not reset you to its
      // first ayah.
      final stored = _lastRead.get(LastReadSource.hifth);
      if (stored?.verseKey.surah != event.surah) {
        await _saveLastRead(header, ayahs.isEmpty ? 1 : ayahs.first.number);
      }
    } catch (_) {
      emit(const HifthError('hifthLoadError'));
    }
  }

  Future<void> _onAyahRead(AyahRead event, Emitter<HifthState> emit) async {
    final current = state;
    if (current is! HifthLoaded) return;
    await _saveLastRead(current.header, event.ayah);
  }

  /// Records where the user is in the hifth flow. Failures are swallowed: a
  /// bookmark that did not persist must not break the screen the user is on.
  Future<void> _saveLastRead(ChapterHeaderDto header, int ayah) async {
    try {
      final verseKey = VerseKey(header.id, ayah);
      await _lastRead.set(
        LastSelectedPage(
          name: header.nameSimple,
          nameArabic: header.nameArabic,
          pageNumber: await _dao.getPageForVerse(verseKey),
          verseKey: verseKey,
          source: LastReadSource.hifth,
          savedAt: DateTime.now().millisecondsSinceEpoch,
        ),
      );
    } catch (_) {
      // Ignored on purpose — see doc comment.
    }
  }
}
