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

/// Persistent bottom app bar for the Quran page. It always carries the reciter
/// (cheikh) dropdown on the leading edge and a mic button on the trailing edge;
/// once recitation mode is on, the extra controls appear between them:
/// hide-text (memorization), restart-to-page-start, next-surah, and exit.
///
/// The bar is brand-locked to [AppColors.greyDarkest] in both themes, the same
/// decision as the AppBar. Its contents therefore always use the dark-surface
/// foreground tokens, whatever the ambient brightness is.
class RecitationBottomBar extends StatelessWidget {
  const RecitationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranRecitationBloc, QuranRecitationState>(
      builder: (context, state) {
        return BottomAppBar(
          height: AppMetrics.audioBar.height,
          padding: AppMetrics.audioBar.padding,
          color: AppColors.greyDarkest,
          child: _Controls(state: state),
        );
      },
    );
  }
}

/// Reciter picker rendered as a compact dropdown pill. Tapping it opens the
/// shared [CheikhPickerSheet] used by the audio player bar.
class _CheikhDropdown extends StatelessWidget {
  const _CheikhDropdown();

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
                Icon(
                  Icons.record_voice_over_rounded,
                  color: accent,
                  size: AppMetrics.audioBar.stopIconSize,
                ),
                const SizedBox(width: 6),
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

class _Controls extends StatelessWidget {
  final QuranRecitationState state;
  const _Controls({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const accent = AppColors.darkPrimary;
    const textColor = AppColors.darkTextPrimary;

    // Logical (start -> end) order only; the ambient locale direction mirrors
    // the whole row, so Arabic reads [play][cheikh] ... [mic] on screen.
    return Row(
      children: [
        _MicButton(state: state),
        if (state.modeActive) ...[
          _BarIcon(
            icon: state.hideText
                ? Icons.visibility_rounded
                : Icons.visibility_off_rounded,
            tooltip: state.hideText
                ? l10n.recitationShowText
                : l10n.recitationHideText,
            color: state.hideText ? accent : textColor,
            onPressed: () =>
                context.read<QuranRecitationBloc>().toggleHideText(),
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
        ],
        const Spacer(),
        const Flexible(child: _CheikhDropdown()),
        _BarIcon(
          icon: Icons.play_arrow_rounded,
          tooltip: l10n.audioPlayPage,
          color: accent,
          onPressed: () => _playPage(context),
        ),
      ],
    );
  }

  /// Queues the whole visible page for the selected cheikh, starting at its
  /// first ayah. Re-tapping while playing restarts from the top of the page.
  void _playPage(BuildContext context) {
    final page = context.read<QuranPageBloc>().state.page;
    if (page == null) return;
    final ayahs = ayahsOnPage(page);
    if (ayahs.isEmpty) return;
    context.read<AudioPlayerBloc>().add(RequestPlayPage(ayahs));
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
  final QuranRecitationState state;
  const _MicButton({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const accent = AppColors.darkPrimary;

    if (state.connecting) {
      return Tooltip(
        message: l10n.recitationConnecting,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox.square(
            dimension: AppMetrics.audioBar.stopIconSize,
            child: CircularProgressIndicator(
              strokeWidth: AppMetrics.audioBar.progressBarHeight,
              valueColor: AlwaysStoppedAnimation<Color>(accent),
            ),
          ),
        ),
      );
    }

    return _BarIcon(
      icon: state.recording ? Icons.stop_rounded : Icons.mic_rounded,
      tooltip: state.recording ? l10n.recitationStop : l10n.recitationStart,
      color: state.recording ? AppColors.darkError : accent,
      onPressed: () => _toggleRecord(context),
    );
  }

  void _toggleRecord(BuildContext context) {
    final bloc = context.read<QuranRecitationBloc>();
    if (state.recording) {
      bloc.stopRecording();
      return;
    }
    final data = _pageWords(context);
    if (data == null || data.words.isEmpty) return;
    bloc.startPage(data.pageNo, data.words);
  }
}

class _BarIcon extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onPressed;

  const _BarIcon({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      tooltip: tooltip,
      iconSize: AppMetrics.audioBar.iconSize,
      onPressed: onPressed,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      constraints: const BoxConstraints(),
      visualDensity: VisualDensity.compact,
    );
  }
}
