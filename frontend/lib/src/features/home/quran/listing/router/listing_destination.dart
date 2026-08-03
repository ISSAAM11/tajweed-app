/// Where the surah listing sends the user when a surah is tapped.
enum ListingDestination {
  /// The mushaf page reader (`/quran-page`).
  quranPage,

  /// The ayah-by-ayah memorization screen (`/hifth`).
  hifth;

  static ListingDestination fromQuery(String? value) => switch (value) {
        'hifth' => ListingDestination.hifth,
        _ => ListingDestination.quranPage,
      };
}
