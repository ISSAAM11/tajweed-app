import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/base/screens/exports.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/cheikh_picker_sheet.dart';

/// Persistent bottom bar of the hifth screen. Its job is the reciter: it always
/// shows who is reciting and opens the shared [CheikhPickerSheet] on tap. While
/// an ayah is playing it also carries the transport controls, so the user never
/// has to scroll back to the tile they started.
///
/// Brand-locked to [AppColors.greyDarkest] in both themes — the same decision as
/// the Quran page bar — so its contents always use the dark foreground tokens.
class HifthBottomBar extends StatelessWidget {
  const HifthBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, audioState) {
        // The shell stays outside the switch so the bar never re-mounts and the
        // list never reflows when playback starts or stops.
        return BottomAppBar(
          height: AppMetrics.audioBar.height,
          padding: AppMetrics.audioBar.padding,
          color: AppColors.greyDarkest,
          child: switch (audioState) {
            AudioDownloading(:final progress) => _DownloadProgress(
              progress: progress,
            ),
            AudioPlaying() || AudioPaused() => _Transport(state: audioState),
            _ => const _IdleControls(),
          },
        );
      },
    );
  }
}

/// Nothing playing: the bar is just the reciter picker.
class _IdleControls extends StatelessWidget {
  const _IdleControls();

  @override
  Widget build(BuildContext context) {
    return const Row(children: [Flexible(child: _CheikhDropdown())]);
  }
}

/// An ayah is playing or paused: the reciter shrinks to a compact pill and the
/// transport controls take the rest of the bar.
class _Transport extends StatelessWidget {
  final AudioPlayerState state;
  const _Transport({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<AudioPlayerBloc>();
    final isPlaying = state is AudioPlaying;

    final (surah, ayah, currentIndex, total) = switch (state) {
      AudioPlaying(
        :final surah,
        :final currentAyah,
        :final currentIndex,
        :final totalInQueue,
      ) ||
      AudioPaused(
        :final surah,
        :final currentAyah,
        :final currentIndex,
        :final totalInQueue,
      ) =>
        (surah, currentAyah, currentIndex, totalInQueue),
      _ => (0, 0, 0, 0),
    };

    return Row(
      children: [
        // Expanded, not Flexible + Spacer: a long reciter name must never push
        // the transport buttons off a narrow screen.
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Flexible(child: _CheikhDropdown(compact: true)),
              Text(
                l10n.audioTrackInfo(surah, ayah, currentIndex + 1, total),
                style: AppFonts.lato
                    .withSize(AppMetrics.audioBar.verseFontSize)
                    .withColor(AppColors.darkTextSecondary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        _BarIcon(
          icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          tooltip: isPlaying ? l10n.audioPause : l10n.audioResume,
          color: AppColors.darkPrimary,
          onPressed: () =>
              bloc.add(isPlaying ? const PauseAudio() : const ResumeAudio()),
        ),
        _BarIcon(
          icon: Icons.stop_rounded,
          tooltip: l10n.audioStop,
          color: AppColors.darkError,
          size: AppMetrics.audioBar.stopIconSize,
          onPressed: () => bloc.add(const StopAudio()),
        ),
      ],
    );
  }
}

/// Reciter picker rendered as a dropdown pill. In [compact] form the leading
/// icon and caret are dropped and only the tappable name remains.
class _CheikhDropdown extends StatelessWidget {
  final bool compact;
  const _CheikhDropdown({this.compact = false});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const accent = AppColors.darkPrimary;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<CheikhCubit, CheikhReciter>(
      builder: (context, cheikh) => Tooltip(
        message: l10n.cheikhPickerTitle,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppMetrics.audioBar.borderRadius),
          onTap: () {
            // Captured here, not resolved inside the sheet: the sheet is a
            // separate route with no access to this screen's providers, and
            // AudioPlayerBloc is a GetIt factory, so looking it up there would
            // yield a second, idle bloc.
            final audio = context.read<AudioPlayerBloc>();
            showModalBottomSheet(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<CheikhCubit>(),
                child: CheikhPickerSheet(
                  onReciterChanged: () => audio.add(const ReciterChanged()),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!compact) ...[
                  Icon(
                    Icons.record_voice_over_rounded,
                    color: accent,
                    size: AppMetrics.audioBar.stopIconSize,
                  ),
                  SizedBox(width: AppMetrics.audioBar.progressSpacing),
                ],
                Flexible(
                  child: Text(
                    isArabic ? cheikh.nameArabic : cheikh.name,
                    style: AppFonts.lato
                        .withSize(AppMetrics.audioBar.infoFontSize)
                        .withColor(accent)
                        .semiBold(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (!compact)
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: accent,
                    size: AppMetrics.audioBar.iconSize,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Surah audio being fetched for offline playback. No cancel button: [StopAudio]
/// does not abort an in-flight download, so offering one would be a lie.
class _DownloadProgress extends StatelessWidget {
  final double progress;
  const _DownloadProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.audioDownloading,
          style: AppFonts.lato
              .withSize(AppMetrics.audioBar.infoFontSize)
              .withColor(AppColors.darkTextPrimary),
        ),
        SizedBox(height: AppMetrics.audioBar.progressSpacing),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.darkSurfaceContainerHighest,
          valueColor: const AlwaysStoppedAnimation<Color>(
            AppColors.darkPrimary,
          ),
          minHeight: AppMetrics.audioBar.progressBarHeight,
          borderRadius: BorderRadius.circular(
            AppMetrics.audioBar.progressBarRadius,
          ),
        ),
      ],
    );
  }
}

class _BarIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final double? size;
  final VoidCallback onPressed;

  const _BarIcon({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onPressed,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      tooltip: tooltip,
      iconSize: size ?? AppMetrics.audioBar.iconSize,
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        horizontal: AppMetrics.audioBar.controlGap,
      ),
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
    );
  }
}
