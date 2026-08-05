import 'package:flutter_test/flutter_test.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/listing/vm/quran_listing_model_helper.dart';

/// Existing installs already hold a `last_selected_page` payload written before
/// the hifth flow existed. Decoding must keep working, or every user loses
/// their bookmark on upgrade.
void main() {
  group('LastSelectedPage', () {
    test('decodes a legacy payload with no source or timestamp', () {
      final page = LastSelectedPage.fromMap({
        'name': 'Al-Fatihah',
        'nameArabic': 'الفاتحة',
        'pageNumber': 1,
        'verseKey': '1:5',
      });

      expect(page.source, LastReadSource.quranPage);
      expect(page.savedAt, 0);
      expect(page.verseKey.surah, 1);
      expect(page.verseKey.ayah, 5);
    });

    test('round-trips source and timestamp', () {
      final original = LastSelectedPage(
        name: 'Al-Baqarah',
        nameArabic: 'البقرة',
        pageNumber: 42,
        verseKey: VerseKey(2, 255),
        source: LastReadSource.hifth,
        savedAt: 1738000000000,
      );

      final restored = LastSelectedPage.fromMap(original.toMap());

      expect(restored.source, LastReadSource.hifth);
      expect(restored.savedAt, 1738000000000);
      expect(restored.pageNumber, 42);
      expect(restored.verseKey.toString(), '2:255');
    });

    test('falls back to the mushaf when the stored source is unknown', () {
      final page = LastSelectedPage.fromMap({
        'name': 'An-Nas',
        'nameArabic': 'الناس',
        'pageNumber': 604,
        'verseKey': '114:1',
        'source': 'somethingRemovedInAFutureVersion',
      });

      expect(page.source, LastReadSource.quranPage);
    });
  });
}
