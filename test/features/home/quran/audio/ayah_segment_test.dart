import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/ayah_segment.dart';

void main() {
  group('AyahSegment', () {
    const seg = AyahSegment(
      surah: 2,
      ayah: 255,
      timestampFrom: 1500,
      timestampTo: 7200,
    );

    test('equal when all fields match', () {
      const same = AyahSegment(
        surah: 2,
        ayah: 255,
        timestampFrom: 1500,
        timestampTo: 7200,
      );
      expect(seg, equals(same));
    });

    test('not equal when any field differs', () {
      const diffAyah = AyahSegment(
        surah: 2,
        ayah: 256,
        timestampFrom: 1500,
        timestampTo: 7200,
      );
      const diffFrom = AyahSegment(
        surah: 2,
        ayah: 255,
        timestampFrom: 0,
        timestampTo: 7200,
      );
      expect(seg, isNot(diffAyah));
      expect(seg, isNot(diffFrom));
    });

    test('props contains surah, ayah, timestampFrom, timestampTo, fullFile', () {
      expect(seg.props, [2, 255, 1500, 7200, false]);
    });

    test('toAudioSource returns ClippingAudioSource with correct start, end and tag', () {
      final source = seg.toAudioSource('/tmp/surah2.mp3') as ClippingAudioSource;
      expect(source.tag, '2:255');
      expect(source.start, const Duration(milliseconds: 1500));
      expect(source.end, const Duration(milliseconds: 7200));
    });

    test('toAudioSource with zero-start segment', () {
      const intro = AyahSegment(
        surah: 1,
        ayah: 1,
        timestampFrom: 0,
        timestampTo: 4885,
      );
      final source = intro.toAudioSource('/tmp/surah1.mp3') as ClippingAudioSource;
      expect(source.start, Duration.zero);
      expect(source.end, const Duration(milliseconds: 4885));
      expect(source.tag, '1:1');
    });

    test('fullFile=true returns plain AudioSource (no clipping)', () {
      const fullSeg = AyahSegment(
        surah: 1,
        ayah: 1,
        timestampFrom: 0,
        timestampTo: 0,
        fullFile: true,
      );
      final source = fullSeg.toAudioSource('/tmp/ayah_1_1.mp3');
      expect(source, isNot(isA<ClippingAudioSource>()));
      expect((source as IndexedAudioSource).tag, '1:1');
    });
  });
}
