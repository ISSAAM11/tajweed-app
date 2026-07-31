import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

class AyahSegment extends Equatable {
  final int surah;
  final int ayah;
  final int timestampFrom;
  final int timestampTo;

  /// When true the segment is a complete standalone file (ayah-level cheikh).
  /// [timestampFrom] and [timestampTo] are ignored; the whole file is played.
  final bool fullFile;

  const AyahSegment({
    required this.surah,
    required this.ayah,
    required this.timestampFrom,
    required this.timestampTo,
    this.fullFile = false,
  });

  AudioSource toAudioSource(String localFilePath) {
    if (fullFile) {
      return AudioSource.file(localFilePath, tag: '$surah:$ayah');
    }
    return ClippingAudioSource(
      child: AudioSource.file(localFilePath),
      start: Duration(milliseconds: timestampFrom),
      end: Duration(milliseconds: timestampTo),
      tag: '$surah:$ayah',
    );
  }

  @override
  List<Object?> get props => [surah, ayah, timestampFrom, timestampTo, fullFile];
}
