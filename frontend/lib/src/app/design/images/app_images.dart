abstract final class AppImages {
  static const imagesFolder = "assets/images";

  static const appLogo = "$imagesFolder/dexter_logo.jpeg";

  // Home/Listing images
  static const backgroundLastRead =
      "$imagesFolder/home/listing/background-last-read.png";
  static const surahNumberBackground =
      "$imagesFolder/home/listing/surah-number-bg.png";
  static const lastReadIcon = "$imagesFolder/home/listing/last-read-icon.png";
  static const quranImage = "$imagesFolder/home/listing/quran-image.png";

  // Hifth screen. The bismillah is white calligraphy on transparency, so it
  // only reads over the gold header; the waveform is a translucent grey strip
  // meant to be tinted per playback state.
  static const hifthTitleBackground =
      "$imagesFolder/home/hifth/title-background.png";
  static const hifthBismillah = "$imagesFolder/home/hifth/bismillah.png";
  static const hifthWaveform = "$imagesFolder/home/hifth/waveform.png";

  // Home action card icons. Full-colour illustrations — render them untinted.
  static const tajweedLessonsIcon = "$imagesFolder/home/tajweed_lessons.png";
  static const quranRecitationIcon = "$imagesFolder/home/quran_recitation.png";
  static const tajweedTestIcon = "$imagesFolder/home/tajweed_test.png";
  static const quranHifthIcon = "$imagesFolder/home/tajweed_hifth.png";
}
