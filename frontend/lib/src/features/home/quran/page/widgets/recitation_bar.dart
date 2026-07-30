import 'package:flutter/material.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/metrics/app_metrics.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/models/cheikh_reciter.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/audio_player_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/audio/vm/cheikh_cubit.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/quran_recitation_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/recitation_words.dart';
import 'package:tajweed_ai/src/features/home/quran/page/widgets/cheikh_picker_sheet.dart';

/// The three mutually exclusive presentations of the Quran page bottom bar.
/// Recitation evaluation and audio playback fight over the same audio route, so
/// the bar never offers both at once.
enum _BarMode { idle, recitation, audio }

/// Both mutual-stop directions dispatch events that resolve asynchronously, so
/// for one frame both blocs can look active. This precedence keeps the bar from
/// ever rendering the mode the user just left.
_BarMode _barModeOf(QuranRecitationState rec, AudioPlayerState audio) {
  // The mic wins the instant it is tapped, before StopAudio has landed.
  if (rec.connecting || rec.recording) return _BarMode.recitation;
  final audioActive =
      audio is AudioPlaying || audio is AudioPaused || audio is AudioDownloading;
  // Playback beats a recitation mode that is still tearing down.
  if (audioActive) return _BarMode.audio;
  if (rec.modeActive) return _BarMode.recitation;
  return _BarMode.idle;
}

/// Persistent bottom app bar for the Quran page, and the only audio surface on
/// it. Idle it offers the mic and the reciter/play pair; once recitation starts
/// the playback affordances give way to the session controls (hide-text,
/// restart, next-surah, exit); once playback starts the mic gives way to the
/// transport controls.
///
/// The bar is brand-locked to [AppColors.greyDarkest] in both themes, the same
/// decision as the AppBar. Its contents therefore always use the dark-surface
/// foreground tokens, whatever the ambient brightness is.
class RecitationBottomBar extends StatelessWidget {
  const RecitationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerBloc, AudioPlayerState>(
      builder: (context, audioState) {
        return BlocBuilder<QuranRecitationBloc, QuranRecitationState>(
          builder: (context, recState) {
            // The shell stays outside the switch so the bar surface never
            // re-mounts and the page never reflows on a mode change.
            return BottomAppBar(
              height: AppMetrics.audioBar.height,
              padding: AppMetrics.audioBar.padding,
              color: AppColors.greyDarkest,
              child: switch (_barModeOf(recState, audioState)) {
                _BarMode.idle => const _IdleControls(),
                _BarMode.recitation => _RecitationControls(state: recState),
                _BarMode.audio => _AudioControls(state: audioState),
              },
            );
          },
        );
      },
    );
  }
}

/// Reciter picker rendered as a compact dropdown pill. Tapping it opens the
/// shared [CheikhPickerSheet]. In [compact] form (used beside the transport
/// controls, where width is scarce) the leading icon and the caret are dropped
/// and only the tappable name remains.
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
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<CheikhCubit>(),
              child: const CheikhPickerSheet(),
            ),
          ),
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

/// Nothing playing, nothing being recited: offer both entry points.
class _IdleControls extends StatelessWidget {
  const _IdleControls();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Logical (start -> end) order only; the ambient locale direction mirrors
    // the whole row, so Arabic reads [play][cheikh] ... [mic] on screen.
    return Row(
      children: [
        const _MicButton(),
        const Spacer(),
        const Flexible(child: _CheikhDropdown()),
        _BarIcon(
          icon: Icons.play_arrow_rounded,
          tooltip: l10n.audioPlayPage,
          color: AppColors.darkPrimary,
          onPressed: () => _playPage(context),
        ),
      ],
    );
  }
}

/// Recitation evaluation is running (or armed): the playback affordances are
/// gone and the session controls take their place.
class _RecitationControls extends StatelessWidget {
  final QuranRecitationState state;
  const _RecitationControls({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const accent = AppColors.darkPrimary;
    const textColor = AppColors.darkTextPrimary;

    return Row(
      children: [
        const _MicButton(),
        _BarIcon(
          icon: state.hideText
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          tooltip: state.hideText
              ? l10n.recitationShowText
              : l10n.recitationHideText,
          color: state.hideText ? accent : textColor,
          onPressed: () => context.read<QuranRecitationBloc>().toggleHideText(),
        ),
        _BarIcon(
          icon: Icons.replay_rounded,
          tooltip: l10n.recitationRestart,
          color: textColor,
          onPressed: () => _restart(context),
        ),
        _BarIcon(
          icon: Icons.skip_next_rounded,
          tooltip: l10n.recitationNextSurah,
          color: textColor,
          onPressed: () => _nextSurah(context),
        ),
        _BarIcon(
          icon: Icons.close_rounded,
          tooltip: l10n.recitationExit,
          color: textColor,
          onPressed: () => context.read<QuranRecitationBloc>().exitMode(),
        ),
        const Spacer(),
      ],
    );
  }

  void _restart(BuildContext context) {
    // "Restart" always returns the pointer to the first word of the page.
    final data = _pageWords(context);
    if (data == null || data.words.isEmpty) return;
    context.read<QuranRecitationBloc>().startPage(data.pageNo, data.words);
  }

  void _nextSurah(BuildContext context) {
    final page = context.read<QuranPageBloc>().state.page;
    if (page == null) return;
    final current = maxSurahOnPage(page);
    if (current == null || current + 1 > 114) return;
    context.read<QuranPageBloc>().initToVerse(VerseKey(current + 1, 1));
  }
}

/// Audio is playing, paused or downloading: the mic is gone and the bar becomes
/// the player. Replaces the floating card this feature used to render over the
/// page.
class _AudioControls extends StatelessWidget {
  final AudioPlayerState state;
  const _AudioControls({required this.state});

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      AudioDownloading(:final progress) => _DownloadProgress(progress: progress),
      _ => _Transport(state: state),
    };
  }
}

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
      ) =>
        (surah, currentAyah, currentIndex, totalInQueue),
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
        // Expanded, not Flexible + Spacer: the transport buttons must never be
        // pushed off a narrow screen by a long reciter name.
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: _CheikhDropdown(compact: true)),
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
          icon: Icons.skip_previous_rounded,
          tooltip: l10n.audioSkipPrevious,
          color: AppColors.darkTextPrimary,
          onPressed: () => bloc.add(const SkipPrevious()),
        ),
        _BarIcon(
          icon: isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
          tooltip: isPlaying ? l10n.audioPause : l10n.audioResume,
          color: AppColors.darkPrimary,
          onPressed: () =>
              bloc.add(isPlaying ? const PauseAudio() : const ResumeAudio()),
        ),
        _BarIcon(
          icon: Icons.skip_next_rounded,
          tooltip: l10n.audioSkipNext,
          color: AppColors.darkTextPrimary,
          onPressed: () => bloc.add(const SkipNext()),
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

/// Queues the whole visible page for the selected cheikh, starting at its first
/// ayah. Any recitation session is dropped first — the mic and the player can't
/// share the audio route.
void _playPage(BuildContext context) {
  final page = context.read<QuranPageBloc>().state.page;
  if (page == null) return;
  final ayahs = ayahsOnPage(page);
  if (ayahs.isEmpty) return;
  final rec = context.read<QuranRecitationBloc>();
  if (rec.state.modeActive) rec.exitMode();
  context.read<AudioPlayerBloc>().add(RequestPlayPage(ayahs));
}

/// The page currently rendered, reduced to the words the backend can score.
({int pageNo, List<({int id, String text})> words})? _pageWords(
  BuildContext context,
) {
  final page = context.read<QuranPageBloc>().state.page;
  if (page == null) return null;
  return (pageNo: page.pageNo, words: recitableWordsFromPage(page));
}

/// Primary affordance of the bar: starts a page recitation (which also turns
/// recitation mode on), stops it, or shows the connecting spinner.
class _MicButton extends StatelessWidget {
  const _MicButton();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final state = context.watch<QuranRecitationBloc>().state;

    if (state.connecting) {
      return Tooltip(
        message: l10n.recitationConnecting,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox.square(
            dimension: AppMetrics.audioBar.stopIconSize,
            child: CircularProgressIndicator(
              strokeWidth: AppMetrics.audioBar.progressBarHeight,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.darkPrimary,
              ),
            ),
          ),
        ),
      );
    }

    return _BarIcon(
      icon: state.recording ? Icons.stop_rounded : Icons.mic_rounded,
      tooltip: state.recording ? l10n.recitationStop : l10n.recitationStart,
      color: state.recording ? AppColors.darkError : AppColors.darkPrimary,
      onPressed: () => _toggleRecord(context, state),
    );
  }

  void _toggleRecord(BuildContext context, QuranRecitationState state) {
    final bloc = context.read<QuranRecitationBloc>();
    if (state.recording) {
      bloc.stopRecording();
      return;
    }
    final data = _pageWords(context);
    if (data == null || data.words.isEmpty) return;
    // Mic and playback can't share the audio route.
    context.read<AudioPlayerBloc>().add(const StopAudio());
    bloc.startPage(data.pageNo, data.words);
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
