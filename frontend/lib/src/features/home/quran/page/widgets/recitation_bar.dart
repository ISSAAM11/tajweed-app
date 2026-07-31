import 'package:flutter/material.dart';
import 'package:tajweed_ai/l10n/app_localizations.dart';
import 'package:tajweed_ai/src/app/design/colors/app_colors.dart';
import 'package:tajweed_ai/src/app/design/metrics/app_metrics.dart';
import 'package:tajweed_ai/src/app/design/styles/app_fonts.dart';
import 'package:tajweed_ai/src/app/design/styles/app_styles.dart';
import 'package:tajweed_ai/src/database/tables/quran/converters.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/quran_page_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/quran_recitation_bloc.dart';
import 'package:tajweed_ai/src/features/home/quran/page/vm/recitation/recitation_words.dart';

/// Persistent bottom app bar for the Quran page. When recitation mode is off it
/// shows a single "start recitation" affordance; when on it becomes the control
/// surface: record toggle, hide-text (memorization), restart-to-page-start,
/// next-surah, and exit.
class RecitationBottomBar extends StatelessWidget {
  const RecitationBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocBuilder<QuranRecitationBloc, QuranRecitationState>(
      builder: (context, state) {
        return BottomAppBar(
          height: AppMetrics.audioBar.height,
          padding: AppMetrics.audioBar.padding,
          color: isDark ? AppColors.darkSurface : Colors.white,
          child: state.modeActive
              ? _Controls(state: state)
              : const _StartToggle(),
        );
      },
    );
  }
}

class _StartToggle extends StatelessWidget {
  const _StartToggle();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkPrimary : AppColors.primary;
    return Center(
      child: TextButton.icon(
        onPressed: () => context.read<QuranRecitationBloc>().enterMode(),
        icon: Icon(Icons.mic_rounded, color: accent),
        label: Text(
          l10n.recitationModeTooltip,
          style: AppFonts.lato
              .withSize(AppMetrics.audioBar.infoFontSize)
              .withColor(accent)
              .semiBold(),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = isDark ? AppColors.darkPrimary : AppColors.primary;
    final textColor = isDark
        ? AppColors.darkTextPrimary
        : AppColors.greyDarkest;

    final statusText = state.connecting
        ? l10n.recitationConnecting
        : state.recording
        ? l10n.recitationListening
        : l10n.recitationModeTooltip;
    final statusIcon = state.connecting
        ? Icons.hourglass_top_rounded
        : state.recording
        ? Icons.graphic_eq_rounded
        : Icons.menu_book_rounded;

    return Row(
      children: [
        Icon(statusIcon, color: accent, size: AppMetrics.audioBar.iconSize),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            statusText,
            style: AppFonts.lato
                .withSize(AppMetrics.audioBar.infoFontSize)
                .withColor(state.recording || state.connecting ? accent : textColor)
                .medium(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _BarIcon(
          icon: state.hideText
              ? Icons.visibility_rounded
              : Icons.visibility_off_rounded,
          tooltip: state.hideText ? l10n.recitationShowText : l10n.recitationHideText,
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
          icon: state.recording ? Icons.stop_rounded : Icons.mic_rounded,
          tooltip: state.recording ? l10n.recitationStop : l10n.recitationStart,
          color: state.recording ? AppColors.error : accent,
          onPressed: () => _toggleRecord(context),
        ),
        _BarIcon(
          icon: Icons.close_rounded,
          tooltip: l10n.recitationExit,
          color: textColor,
          onPressed: () => context.read<QuranRecitationBloc>().exitMode(),
        ),
      ],
    );
  }

  ({int pageNo, List<({int id, String text})> words})? _pageWords(
    BuildContext context,
  ) {
    final page = context.read<QuranPageBloc>().state.page;
    if (page == null) return null;
    return (pageNo: page.pageNo, words: recitableWordsFromPage(page));
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
