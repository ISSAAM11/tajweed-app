import 'package:equatable/equatable.dart';

enum CheikhAudioType {
  /// One MP3 per surah; ayah boundaries are timestamp segments within the file.
  surahLevel,

  /// One MP3 per ayah; audio_url is per-row in the `verses` table.
  ayahLevel,
}

class CheikhReciter extends Equatable {
  final String id;
  final String name;
  final String nameArabic;
  final String dbAssetPath;

  const CheikhReciter({
    required this.id,
    required this.name,
    required this.nameArabic,
    required this.dbAssetPath,
  });

  /// Derived from naming convention: "ayah-recitation-*" → ayahLevel.
  CheikhAudioType get audioType => dbAssetPath.contains('ayah-recitation')
      ? CheikhAudioType.ayahLevel
      : CheikhAudioType.surahLevel;

  @override
  List<Object?> get props => [id];
}

const kDefaultCheikh = CheikhReciter(
  id: 'ahmad-alnufais',
  name: 'Ahmad Al-Nufais',
  nameArabic: 'أحمد النفيس',
  dbAssetPath: 'assets/db/surah-recitation-ahmad-alnufais.db',
);
