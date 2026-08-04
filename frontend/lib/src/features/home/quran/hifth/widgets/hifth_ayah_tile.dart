import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/vm/hifth_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/widgets/hifth_waveform.dart';

/// One ayah of the hifth list: a rounded header row (number badge + play and
/// repeat buttons) above the Arabic text, closed by a divider.
class HifthAyahTile extends StatelessWidget {
  final int surah;
  final HifthAyah ayah;

  const HifthAyahTile({required this.surah, required this.ayah, super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.hifthScreen;

    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, audioState) {
        final isThisAyah = switch (audioState) {
          AudioPlaying(:final surah, :final currentAyah) ||
          AudioPaused(:final surah, :final currentAyah) =>
            surah == this.surah && currentAyah == ayah.number,
          _ => false,
        };
        final isPlaying = isThisAyah && audioState is AudioPlaying;
        final isLooping = isThisAyah &&
            switch (audioState) {
              AudioPlaying(:final looping) ||
              AudioPaused(:final looping) =>
                looping,
              _ => false,
            };

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: metrics.tileHeaderHeight,
              padding: metrics.tileHeaderPadding,
              decoration: BoxDecoration(
                color: isThisAyah
                    ? AppColors.ayahHighlight
                    : AppColors.hifthTileBackground,
                borderRadius:
                    BorderRadius.circular(metrics.tileHeaderRadius),
              ),
              child: Row(
                children: [
                  Container(
                    width: metrics.badgeSize,
                    height: metrics.badgeSize,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.hifthGold,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${ayah.number}',
                      style: AppFonts.poppins
                          .withSize(FontSizes.subtitle)
                          .withColor(AppColors.scaffold)
                          .medium(),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: metrics.waveformMargin,
                      child: HifthWaveform(active: isThisAyah),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _onPlayTap(context, isPlaying, isThisAyah),
                    iconSize: metrics.actionIconSize,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_rounded
                          : Icons.play_arrow_rounded,
                      color: AppColors.hifthGold,
                    ),
                  ),
                  SizedBox(width: metrics.actionIconGap),
                  IconButton(
                    onPressed: () => _onRepeatTap(context, isLooping),
                    iconSize: metrics.actionIconSize,
                    icon: Icon(
                      isLooping ? Icons.repeat_one_rounded : Icons.repeat_rounded,
                      color: isLooping
                          ? AppColors.primaryDark
                          : AppColors.hifthGold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: metrics.textTopSpacing),
            Text(
              ayah.text,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppFonts.uthmanicHafsFont
                  .withSize(FontSizes.headline4)
                  .withColor(AppColors.greyDarkest)
                  .copyWith(height: metrics.ayahTextHeight),
            ),
            SizedBox(height: metrics.textBottomSpacing),
            const Divider(color: AppColors.divider, height: 1),
            SizedBox(height: metrics.tileBottomSpacing),
          ],
        );
      },
    );
  }

  void _onPlayTap(BuildContext context, bool isPlaying, bool isThisAyah) {
    final bloc = context.read<AudioPlayerBloc>();
    if (isPlaying) {
      bloc.add(const PauseAudio());
    } else if (isThisAyah) {
      bloc.add(const ResumeAudio());
    } else {
      bloc.add(RequestPlayAyah(surah, ayah.number));
    }
  }

  void _onRepeatTap(BuildContext context, bool isLooping) {
    final bloc = context.read<AudioPlayerBloc>();
    if (isLooping) {
      bloc.add(const StopAudio());
    } else {
      bloc.add(RequestPlayAyah(surah, ayah.number, loop: true));
    }
  }
}
