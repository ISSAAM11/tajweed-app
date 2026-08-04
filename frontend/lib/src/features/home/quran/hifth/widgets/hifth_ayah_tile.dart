import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/vm/hifth_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/hifth/widgets/hifth_waveform.dart';
import 'package:tajweed_ai/src/features/home/quran/page/datasource/cache/marked_ayah_cache.dart';

/// One ayah of the hifth list: a rounded header row (number badge, playback
/// waveform, and the play / repeat / mark buttons) above the Arabic text,
/// closed by a divider.
///
/// Marks come from the app-wide [MarkedAyahService], the same store the mushaf
/// page writes to, so an ayah marked here shows as marked there too.
class HifthAyahTile extends StatelessWidget {
  final int surah;
  final HifthAyah ayah;

  const HifthAyahTile({required this.surah, required this.ayah, super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.hifthScreen;
    final l10n = AppLocalizations.of(context)!;
    final marksService = get<MarkedAyahService>();

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

        return ValueListenableBuilder<Set<String>>(
          valueListenable: marksService.marks,
          builder: (context, marks, _) {
            final isMarked = marks.contains(
              MarkedAyahService.keyOf(surah, ayah.number),
            );

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
                      _TileIcon(
                        icon: isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        tooltip: isPlaying ? l10n.audioPause : l10n.audioResume,
                        color: AppColors.hifthGold,
                        onPressed: () =>
                            _onPlayTap(context, isPlaying, isThisAyah),
                      ),
                      SizedBox(width: metrics.actionIconGap),
                      _TileIcon(
                        icon: isLooping
                            ? Icons.repeat_one_rounded
                            : Icons.repeat_rounded,
                        tooltip: l10n.hifthRepeatTooltip,
                        color: isLooping
                            ? AppColors.primaryDark
                            : AppColors.hifthGold,
                        onPressed: () => _onRepeatTap(context, isLooping),
                      ),
                      SizedBox(width: metrics.actionIconGap),
                      _TileIcon(
                        icon: isMarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        tooltip: isMarked
                            ? l10n.ayahUnmarkTooltip
                            : l10n.ayahMarkTooltip,
                        color: AppColors.hifthGold,
                        onPressed: () =>
                            marksService.toggle(surah, ayah.number),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: metrics.textTopSpacing),
                // Padded whether or not it is marked, so toggling a mark tints
                // the block instead of reflowing the verse.
                Container(
                  padding: metrics.markedTextPadding,
                  decoration: BoxDecoration(
                    color: isMarked
                        ? AppColors.ayahMarked
                        : AppColors.transparent,
                    borderRadius:
                        BorderRadius.circular(metrics.markedTextRadius),
                  ),
                  child: Text(
                    ayah.text,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppFonts.uthmanicHafsFont
                        .withSize(FontSizes.headline4)
                        .withColor(AppColors.greyDarkest)
                        .copyWith(height: metrics.ayahTextHeight),
                  ),
                ),
                SizedBox(height: metrics.textBottomSpacing),
                const Divider(color: AppColors.divider, height: 1),
                SizedBox(height: metrics.tileBottomSpacing),
              ],
            );
          },
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
      _markRead(context);
    }
  }

  void _onRepeatTap(BuildContext context, bool isLooping) {
    final bloc = context.read<AudioPlayerBloc>();
    if (isLooping) {
      bloc.add(const StopAudio());
    } else {
      bloc.add(RequestPlayAyah(surah, ayah.number, loop: true));
      _markRead(context);
    }
  }

  /// Starting an ayah is the clearest signal of where the user is working, so
  /// it is what moves the hifth bookmark. Pause and resume deliberately do not.
  void _markRead(BuildContext context) =>
      context.read<HifthBloc>().add(AyahRead(ayah.number));
}

/// Compact action button for the tile header. The default [IconButton] tap
/// target is 48dp, and three of those plus the waveform do not fit on a narrow
/// phone, so the target is tightened to [_HifthScreen.actionTapSize].
class _TileIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onPressed;

  const _TileIcon({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final metrics = AppMetrics.hifthScreen;
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      iconSize: metrics.actionIconSize,
      padding: EdgeInsets.zero,
      constraints: BoxConstraints.tightFor(
        width: metrics.actionTapSize,
        height: metrics.actionTapSize,
      ),
      visualDensity: VisualDensity.compact,
      icon: Icon(icon, color: color),
    );
  }
}
