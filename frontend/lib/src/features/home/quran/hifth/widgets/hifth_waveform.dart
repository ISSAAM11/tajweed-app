import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/services/quran_audio_player_service.dart';

/// Peak alpha of the waveform artwork. The strip is drawn at roughly a third
/// of full opacity, which reads as washed out once tinted, so [_solidTint]
/// scales it back up to full strength.
const double _artworkPeakAlpha = 89;

/// Recolours every pixel of the waveform art to [color] and lifts its alpha to
/// full strength. Alpha is scaled rather than replaced, so the transparent gaps
/// between the bars stay transparent and the bar edges keep their antialiasing.
ColorFilter _solidTint(Color color) => ColorFilter.matrix(<double>[
  0, 0, 0, 0, color.r * 255,
  0, 0, 0, 0, color.g * 255,
  0, 0, 0, 0, color.b * 255,
  0, 0, 0, 255 / _artworkPeakAlpha, 0,
]);

/// The playback waveform in an ayah tile header.
///
/// [active] means this ayah is the one loaded in the player, so the bar tracks
/// its position; every other tile draws the same strip flat and unplayed.
///
/// Position is read straight off [QuranAudioPlayerService] rather than through
/// [AudioPlayerBloc]: it ticks several times a second, and routing it through
/// bloc state would rebuild the entire ayah list on every tick. Subscribing
/// here keeps the rebuild inside the one tile that is playing.
class HifthWaveform extends StatelessWidget {
  final bool active;

  const HifthWaveform({required this.active, super.key});

  @override
  Widget build(BuildContext context) {
    if (!active) return const _WaveBar(progress: 0);

    final player = get<QuranAudioPlayerService>();
    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, durationSnapshot) {
        // For a surah-level reciter the queue item is a clip of the full-surah
        // file, so both duration and position are already ayah-relative.
        final total = durationSnapshot.data?.inMilliseconds ?? 0;
        return StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, positionSnapshot) {
            final elapsed = positionSnapshot.data?.inMilliseconds ?? 0;
            return _WaveBar(progress: total <= 0 ? 0 : elapsed / total);
          },
        );
      },
    );
  }
}

class _WaveBar extends StatelessWidget {
  final double progress;

  const _WaveBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final height = AppMetrics.hifthScreen.waveformHeight;
    final played = progress.clamp(0.0, 1.0);

    return SizedBox(
      height: height,
      // Both layers are laid out at the full width so their bars line up
      // exactly; only the played one is clipped.
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            _wave(AppColors.hifthWaveRemaining, constraints.maxWidth, height),
            if (played > 0)
              ClipRect(
                child: Align(
                  // Directional so the fill runs from the start edge, which
                  // mirrors with the row in Arabic.
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: played,
                  child: _wave(
                    AppColors.hifthWavePlayed,
                    constraints.maxWidth,
                    height,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _wave(Color color, double width, double height) => ColorFiltered(
    colorFilter: _solidTint(color),
    child: Image.asset(
      AppImages.hifthWaveform,
      width: width,
      height: height,
      fit: BoxFit.fill,
    ),
  );
}
