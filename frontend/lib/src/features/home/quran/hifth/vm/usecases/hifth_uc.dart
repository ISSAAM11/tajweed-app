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
    } catch (_) {
      emit(const HifthError('hifthLoadError'));
    }
  }
}
